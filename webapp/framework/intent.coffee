transition = (params...) -> this.postMessage params

worker = (func)->
  this.onmessage = (e)->
    try
      func.apply this, e.data
    finally
      close()

module.exports = {worker, transition}