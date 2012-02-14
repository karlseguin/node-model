helper = require('./helper')
model = helper.require('./src/index')

class Base
  @count: 1
  @ping: -> 'pong'

class Test extends model.Model
  @attr 'name', model.types.string
  @attr 'score', model.types.integer

describe 'Model', ->
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

  it "defines the attributes", ->
    expect(Test.attributes.name).toEqual(1)
    expect(Test.attributes.score).toEqual(2)

  it "creates an empty mobject", ->
    test = new Test()
    expect(test.name).toBeNull()
    expect(test.score).toBeNull()

  it "creates an object from a hash", ->
    test = new Test({name: 'leto', score: 9001, flag: false, dob: new Date()})
    expect(test.name).toEqual('leto')
    expect(test.score).toEqual(9001)
    expect(test.flag).toBeUndefined()
    expect(test.dob).toBeUndefined()