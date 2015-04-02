# state command

channel = require 'pubsub-js'
state   = require 'framework/state'

handler = (trans_name, func) ->
  channel.subscribe "transition.#{trans_name}", (ignored, params)->
    func.apply state, params

module.exports = {handler, state}
