channel = require 'pubsub-js'
store   = require 'store'

handler = (evt, func) ->
  channel.register "store_event.#{evt}", (params)->
    try
      func.apply this, params
    finally
      store.commit()

module.exports = {handler, store}