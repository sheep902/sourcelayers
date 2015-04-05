React = require 'react'

state = require 'framework/state'

channel = require 'pubsub-js'
{handler, state} = require 'framework/transition'

# A React component mixin
react_mixin =
  mixins: [state.mixin]

#  cursors: {}

  _intents: {}

  cancel_all: (cmd_name)->
    @_intents[cmd_name]?.map (intent)-> intent.terminate()
    delete @_intents[cmd_name]

  intent: (cmd_name, params...)->
    worker = require "intents/#{cmd_name}"
    intent = new worker
    (@_intents[cmd_name] ||= []).add intent

    intent.onmessage = (e) ->
      evt_params = e.data.clone()
      evt_name = evt_params.shift()
      channel.publish "transition.#{evt_name}", evt_params

    intent.postMessage(params)

#  transitions: {}

  componentWillMount: ->
    @transitions?.keys (trans_name, handler)->
      token = channel.subscribe "transition.#{trans_name}", (ignored, params)->
        handler.apply state, params

      (@_trans_handlers ||= []).add token

  componentWillUnmount: ->
    @_trans_handlers.map (handler)->
      channel.unsubscribe handler

    @_trans_handlers = []

module.exports = (obj)->
  obj.mixins = [react_mixin].add obj.mixins
  React.createClass obj
