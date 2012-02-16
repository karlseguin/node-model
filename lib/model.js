(function() {
  var Model, moduleKeywords, ruleTypes, types,
    __indexOf = Array.prototype.indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  moduleKeywords = ['extended', 'included'];

  types = require('./types');

  ruleTypes = {
    presence: 1,
    length: 2
  };

  Model = (function() {

    Model.extend = function(obj) {
      var key, value, _ref;
      for (key in obj) {
        value = obj[key];
        if (__indexOf.call(moduleKeywords, key) < 0) this[key] = value;
      }
      if ((_ref = obj.extended) != null) _ref.apply(this);
      return this;
    };

    Model.include = function(obj) {
      var key, value, _ref;
      for (key in obj) {
        value = obj[key];
        if (__indexOf.call(moduleKeywords, key) < 0) this.prototype[key] = value;
      }
      if ((_ref = obj.included) != null) _ref.apply(this);
      return this;
    };

    Model.attr = function(name, type) {
      if (this._attributes == null) this._attributes = {};
      return this._attributes[name] = type;
    };

    Model.validatePresence = function(name, message) {
      return this.addValidationRule(name, ruleTypes.presence, null, message);
    };

    Model.validateLength = function(name, options, message) {
      return this.addValidationRule(name, ruleTypes.length, options, message);
    };

    Model.addValidationRule = function(name, type, options, message) {
      if (this._rules == null) this._rules = {};
      if (this._rules[name] == null) this._rules[name] = [];
      return this._rules[name].push({
        type: type,
        options: options,
        message: message
      });
    };

    function Model(params) {
      var name, type, value, _ref;
      _ref = this.constructor._attributes;
      for (name in _ref) {
        type = _ref[name];
        value = params != null ? params[name] : void 0;
        if (!(value != null)) {
          value = null;
        } else if (type === types.integer) {
          value = parseInt(value);
          if (isNaN(value)) value = null;
        }
        this[name] = value;
      }
    }

    Model.prototype.validate = function() {
      var name, rule, rules, value, _i, _len, _ref;
      this.errors = {};
      _ref = this.constructor._rules;
      for (name in _ref) {
        rules = _ref[name];
        for (_i = 0, _len = rules.length; _i < _len; _i++) {
          rule = rules[_i];
          value = this[name];
          if (rule.options && rule.options.required && !(value != null)) {
            this._addError(name, rule.message);
          } else if (rule.type === ruleTypes.presence) {
            if (value == null) this._addError(name, rule.message);
          } else if (rule.type === ruleTypes.length) {
            if (((rule.options.min != null) && value.length < rule.options.min) || ((rule.options.max != null) && value.length > rule.options.max)) {
              this._addError(name, rule.message);
            }
          }
        }
      }
      return Object.keys(this.errors).length === 0;
    };

    Model.prototype._addError = function(name, message) {
      if (this.errors[name] == null) this.errors[name] = [];
      return this.errors[name].push(message);
    };

    return Model;

  })();

  module.exports = Model;

}).call(this);
