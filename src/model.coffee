moduleKeywords = ['extended', 'included']
types = require('./types')

ruleTypes =
  presence: 1
  length: 2

class Model
  @extend: (obj) ->
    for key, value of obj when key not in moduleKeywords
      @[key] = value

    obj.extended?.apply(@)
    this

  @include: (obj) ->
    for key, value of obj when key not in moduleKeywords
      @::[key] = value

    obj.included?.apply(@)
    this

  @attr: (name, type) ->
    @_attributes = {} unless @_attributes?
    @_attributes[name] = type

  @validatePresence: (name, message) ->
    @addValidationRule name, ruleTypes.presence, null, message

  @validateLength: (name, options, message) ->
    @addValidationRule name, ruleTypes.length, options, message

  @addValidationRule: (name, type, options, message) ->
    @_rules = {} unless @_rules?
    @_rules[name] = [] unless @_rules[name]?
    @_rules[name].push({type: type, options: options, message: message})

  constructor: (params) ->
    for name, type of @.constructor._attributes
      value = params?[name]
      if !value?
        value = null
      else if type == types.integer
        value = parseInt(value)
        value = null if isNaN(value)
      @[name] = value

  validate: ->
    @errors = {}
    for name, rules of @.constructor._rules
      for rule in rules
        value = @[name]
        if rule.options && rule.options.required && !value?
          @_addError(name, rule.message)
        else if rule.type == ruleTypes.presence
          @_addError(name, rule.message) unless value?
        else if rule.type == ruleTypes.length
          @_addError(name, rule.message) if (rule.options.min? && value.length < rule.options.min ) || (rule.options.max? && value.length > rule.options.max)

    return Object.keys(@errors).length == 0

  _addError: (name, message) ->
    @errors[name] = [] unless @errors[name]?
    @errors[name].push(message)

module.exports = Model