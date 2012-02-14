moduleKeywords = ['extended', 'included']
types = require('./types')

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
    @attributes = {} unless @attributes?
    @attributes[name] = type

  constructor: (params) ->
    for name, type of @.constructor.attributes
      value = params?[name]
      if !value?
        value = null
      else if type == types.integer
        value = parseInt(value)
        value = null if isNaN(value)

      @[name] = value

module.exports = Model