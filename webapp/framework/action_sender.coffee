channel = require 'pubsub-js'

# A React component mixin
module.exports =
  send_action: (action_handler, params...)->
    worker = new action_handler
    worker.postMessage(params)

    worker.onmessage (e) ->
      params = e.data
      channel.publish "store_event.#{params[0]}", params[1..-1]