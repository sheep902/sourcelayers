React = require 'react'

state = require 'framework/state'

channel = require 'pubsub-js'
{handler} = require 'framework/transition'

# A React component mixin
react_mixin =
  mixins: [state.mixin]

#  cursors: {}

  _intents: {}

  cancel_all: (intent_name)->
    # TODO cancelling command intents will be troublesome
    @_intents[intent_name]?.map (intent)->
      # intent.terminate() is syntactically better but it makes Chrome aw,snap :(
      intent.close()
    delete @_intents[intent_name]

  intent: (intent_name, params...)->
    worker = require "intents/#{intent_name}"
    intent = new worker
    (@_intents[intent_name] ||= []).add intent

    intent.onmessage = (e) ->
      trans_params = e.data.clone()
      trans_name = trans_params.shift()
      channel.publish "transition.#{trans_name}", trans_params
    intent.postMessage params

#  transitions: {}

  componentWillMount: ->
    @transitions?.keys (trans_name, func)=>
      token = handler trans_name, func, this
      (@_trans_handlers ||= []).add token

  componentWillUnmount: ->
    @_trans_handlers.map (handler)->
      channel.unsubscribe handler

    @_trans_handlers = []

module.exports = (obj)->
  obj.mixins = [react_mixin].add obj.mixins
  React.createClass obj
