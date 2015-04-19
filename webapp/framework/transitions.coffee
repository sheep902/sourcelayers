transitions = {}

transition_names =
  require.context('../transitions', yes, /\.coffee$/).keys().map (name)-> name[2..-8]

in_worker = self.WorkerGlobalScope?

console.trace()

if in_worker
  transition_names.forEach (name)->
    transitions[name] = (params)->
      @postMessage name: name, params: params
else
  channel = require 'pubsub-js'

  transition_names.forEach (name)->
    channel.subscribe name, (params)->
      transition = require "transitions/#{name}"
      transition params

module.exports = transitions
