{intent} = require 'framework/framework'
{did_happen} = require 'framework/events'

module.exports = intent (params)->
  did_happen 'param'
