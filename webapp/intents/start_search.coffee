{intent} = require 'framework/framework'
{did_happen} = require 'framework/events'

{sign_up} = require 'framework/server'

module.exports = intent (params)->
  did_happen params
