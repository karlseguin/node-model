(function() {
  var Model, moduleKeywords, types,
    __indexOf = Array.prototype.indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  moduleKeywords = ['extended', 'included'];

  types = require('./types');

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
      if (this.attributes == null) this.attributes = {};
      return this.attributes[name] = type;
    };

    function Model(params) {
      var name, type, value, _ref;
      _ref = this.constructor.attributes;
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

    return Model;

  })();

  module.exports = Model;

}).call(this);
