# actions handlers are actors running in dedicated web workers
# send_event is their only way to return result
# be sure to call
#   handler_instance.onmessage (message) -> channel.publish 'store_event', message
# for each action handler instance

handler = (func)->
  addEventListener 'message', (e)->
    try
      func.apply this, e.data
    finally
      close()

# func accepts store.root()
send_event = (params...)->
  postMessage params

module.exports = {handler, send_event}