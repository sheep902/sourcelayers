{intent} = require 'framework/framework'
{did_happen} = require 'framework/events'

{call_command} = require 'framework/server'

module.exports = intent (params)->
  did_happen params
