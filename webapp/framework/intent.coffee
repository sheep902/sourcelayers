transition = (params...) -> this.postMessage params

worker = (func)->
  this.addEventListener 'message', (e)-> close() if e.data is 'terminate'

  this.onmessage = (e)->
    try
      func.apply this, e.data
    finally
      close()

module.exports = {worker, transition}