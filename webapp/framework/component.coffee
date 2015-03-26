React = require 'react'

channel = require 'pubsub-js'
store = require 'framework/store'

# A React component mixin
react_mixin =
  mixins: [store.mixin]

  start: (cmd_name, params...)->
    worker = require "commands/#{cmd_name}"
    handler = new worker
    handler.onmessage = (e) ->
      evt_params = e.data.clone()
      evt_name = evt_params.shift()
      channel.publish "event.#{evt_name}", evt_params

    handler.postMessage(params)

  # shortcut for simple actions
  event: (params...)->
    @start 'emit', params...

  # pass queries to baobab mixin
  cursors: ->
    ({}.merge @queries).map (local_name, query_params)=>
      query_params = query_params.clone()

      query_params = if query_params.isArray() then query_params else [query_params]
      query_name = query_params.shift()

      partial_cursors = {}
      partial_cursors[local_name] = require("queries/#{query_name}") query_params
      partial_cursors
    .reduce (q1, q2)-> q1.merge q2

module.exports = (obj)->
  obj.mixins = [react_mixin].add obj.mixins
  React.createClass obj
