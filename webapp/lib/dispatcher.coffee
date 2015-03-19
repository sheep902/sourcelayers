PubSub = require 'pubsub'
UUID = require 'node-uuid'

PubSub.action = (type, payload)->
  uuid = UUID.v4()
  PubSub.publish type, {action_id: uuid}.merge(payload)
  uuid

module.exports = PubSub