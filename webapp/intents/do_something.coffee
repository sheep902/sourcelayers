{intent} = require 'framework/framework'
{did_transition} = require 'framework/transitions'

module.exports = intent (params)->
  did_transition 'do something'
