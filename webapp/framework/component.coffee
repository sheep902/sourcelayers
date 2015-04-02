React = require 'react'

channel = require 'pubsub-js'
store = require 'framework/state'

# A React component mixin
react_mixin =
  mixins: [store.mixin]

  intents: {}

  forget: (cmd_name)->
    @intents[cmd_name]?.map (intent)-> intent.terminate
    delete @intents[cmd_name]

  intent: (cmd_name, params...)->
    worker = require "intents/#{cmd_name}"
    intent = new worker

    @intents[cmd_name] ||= []
    @intents[cmd_name].add intent

    intent.onmessage = (e) ->
      evt_params = e.data.clone()
      evt_name = evt_params.shift()
      channel.publish "transition.#{evt_name}", evt_params

    intent.postMessage(params)

module.exports = (obj)->
  obj.mixins = [react_mixin].add obj.mixins
  React.createClass obj
