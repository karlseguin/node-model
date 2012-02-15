# Models for Node
[![Build Status](https://secure.travis-ci.org/karlseguin/node-model.png)](http://travis-ci.org/karlseguin/node-model)

A lightweight base model object. This is currently storage-agnostic (and may remain that way). It is meant to provide a simple facility for binding a hash-input (as you might receive from an http request) to an object, and providing validation features.


# Usage


    model = require('node-model')

    class User extends model.Model
          @attr 'name', model.types.string
          @attr 'age',  model.types.integer
          @validateLength 'name', {required: true, min: 2, max: 20}, 'please enter a name'
          @validatePresence 'age', 'please enter an age'

You can now create a `User` directly from a hash input: `user = new User(req.query)`.

You can also call `user.validate()` which will return true or false. When false is returned, you can access `user.errors` for a list of errors