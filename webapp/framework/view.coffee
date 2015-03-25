React = require 'react'

channel = require 'pubsub-js'
store = require 'framework/store'

emit = require 'commands/emit'

# A React component mixin
react_mixin =
  mixins: [store.mixin]

  start: (cmd_name, params...)->
    worker = require.context('..')("./commands/#{cmd_name}")
    handler = new worker
    handler.onmessage = (e) ->
      evt_name = e.data[0]
      params = e.data[1..-1]
      channel.publish "event.#{evt_name}", params

    handler.postMessage(params)

  emit: (params...)-> # shortcut
    start emit, params

  read: (query, params...)->
    query params

module.exports = (obj)->
  obj.mixins = [react_mixin].add obj.mixins
  React.createClass obj
