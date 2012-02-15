helper = require('./../helper')
model = helper.require('./src/index')

class Test extends model.Model
  @attr 'name', model.types.string
  @attr 'score', model.types.integer
  @validateLength 'name', {required: true, min: 2, max: 5}, 'please enter a name'
  @validatePresence 'score', 'please enter a score'


describe 'Model Validation', ->

  it "validates presence", ->
    test = new Test()
    expect(test.validate()).toEqual(false)
    expect(test.errors['score'].length).toEqual(1)
    expect(test.errors['score'][0]).toEqual('please enter a score')

  it "validates required", ->
    test = new Test()
    expect(test.validate()).toEqual(false)
    expect(test.errors['name'].length).toEqual(1)
    expect(test.errors['name'][0]).toEqual('please enter a name')

  it "validates min length", ->
    test = new Test({name: '1'})
    expect(test.validate()).toEqual(false)
    expect(test.errors['name'].length).toEqual(1)
    expect(test.errors['name'][0]).toEqual('please enter a name')

  it "validates max length", ->
    test = new Test({name: '123456'})
    expect(test.validate()).toEqual(false)
    expect(test.errors['name'].length).toEqual(1)
    expect(test.errors['name'][0]).toEqual('please enter a name')

  it "valid object is valid", ->
    test = new Test({name: '12345', score: '44'})
    expect(test.validate()).toEqual(true)