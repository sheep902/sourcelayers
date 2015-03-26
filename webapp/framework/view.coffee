React = require 'react'

channel = require 'pubsub-js'
store = require 'framework/store'

# A React component mixin
react_mixin =
  mixins: [store.mixin]

  start: (cmd_name, params...)->
    worker = require.context('..')("./commands/#{cmd_name}")
    handler = new worker
    handler.onmessage = (e) ->
      evt_name = e.data[0]
      evt_params = e.data[1..-1]
      channel.publish "event.#{evt_name}", evt_params

    handler.postMessage(params)

  # shortcut for simple actions
  event: (params...)->
    @start 'emit', params...

  __queries: []

  # pass queries to baobab mixin
  cursors: -> # todo ugly
    (@__queries.add @queries).map (query)->
      query_params= if query.isArray() then query else [query]
      query_name = query_params.shift()

      require.context('..')("./queries/#{query_name}").apply(this, query_params)

module.exports = (obj)->
  obj.mixins = [react_mixin].add obj.mixins
  React.createClass obj
