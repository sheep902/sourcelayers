channel = require 'pubsub-js'
store   = require 'framework/store'

handler = (evt_name, func) ->
  channel.subscribe "event.#{evt_name}", (ignored, params)->
    try
      func.apply store, params
    finally
      store.commit()

module.exports = {handler, store}