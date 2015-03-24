# actions handlers are actors running in dedicated web workers
# send_event is their only way to return result
# be sure to call
#   handler_instance.onmessage (message) -> channel.publish 'store_event', message
# for each action handler instance

handler = (worker, func)->
  worker['send_event'] = (params...) -> worker.postMessage params

  worker.addEventListener 'message', (e)->
    try
      func.apply worker, e.data
    finally
      worker.close()

module.exports = {handler}