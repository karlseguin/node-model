moduleKeywords = ['extended', 'included']

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
    for name of @.constructor.attributes
      @[name] = if params?[name]? then params[name] else null

module.exports.Model = Model
module.exports.types =
  string: 1
  integer: 2