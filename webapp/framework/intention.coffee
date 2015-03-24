channel = require 'pubsub-js'

# A React component mixin
module.exports =
  start: (command, params...)->
    worker = new command
    worker.onmessage (e) ->
      params = e.data
      channel.publish "store_event.#{params[0]}", params[1..-1]

    worker.postMessage(params)

  read: (query, params)->
