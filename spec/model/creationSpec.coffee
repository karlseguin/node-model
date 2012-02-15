helper = require('./../helper')
model = helper.require('./src/index')

class Test extends model.Model
  @attr 'name', model.types.string
  @attr 'score', model.types.integer

describe 'Model Creation', ->

  it "defines the attributes", ->
    expect(Test._attributes.name).toEqual(1)
    expect(Test._attributes.score).toEqual(2)

  it "creates an empty mobject", ->
    test = new Test()
    expect(test.name).toBeNull()
    expect(test.score).toBeNull()

  it "constructor creates an object from a hash and converts types", ->
    test = new Test({name: 'leto', score: 9001, flag: false, dob: new Date()})
    expect(test.name).toEqual('leto')
    expect(test.score).toEqual(9001)
    expect(test.flag).toBeUndefined()
    expect(test.dob).toBeUndefined()
