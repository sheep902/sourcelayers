# actions handlers are actors running in dedicated web workers
# emit is their only way to return result

emit = (params...) -> this.postMessage params

handler = (func)->
  this.onmessage = (e)->
    try
      func.apply this, e.data
    finally
      close()

module.exports = {handler, emit}