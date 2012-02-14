helper = require('./../helper')
model = helper.require('./src/index')

class Base
  @count: 1
  @ping: -> 'pong'

describe 'Model Modules', ->
  it "extends class members", ->
    class Extending extends model.Model
      @extend Base

    extending = new Extending()
    expect(Extending.count).toEqual(1)
    expect(Extending.ping()).toEqual('pong')
    expect(extending.count).toBeUndefined()
    expect(extending.ping).toBeUndefined()

  it "includes instance members", ->
    class Including extends model.Model
      @include Base

    including = new Including()
    expect(including.count).toEqual(1)
    expect(including.ping()).toEqual('pong')
    expect(Including.count).toBeUndefined()
    expect(Including.ping).toBeUndefined()