# state command

channel = require 'pubsub-js'
state   = require 'framework/state'

handler = (evt_name, func) ->
  channel.subscribe "transition.#{evt_name}", (ignored, params)->
    try
      func.apply state, params
    finally
      state.commit()

module.exports = {handler, state}