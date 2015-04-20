channel = require 'pubsub-js'

events = {}

event_names =
  require.context('../events', yes, /\.coffee$/).keys().map (name)-> name[2..-8]

event_names.forEach (name)->
  channel.subscribe name, (params)->
    transition = require "events/#{name}"
    transition params

  events[name] = (params)-> channel.publish name, params

module.exports = events
