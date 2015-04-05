# state command

channel = require 'pubsub-js'

handler = (trans_name, func, self=this) ->
  channel.subscribe "transition.#{trans_name}", (ignored, params)->
    func.apply self, params

module.exports = {handler}
