channel = require 'pubsub-js'

intents = {}

intent_names = require.context('../intents', yes, /\.coffee$/).keys().map (name)-> name[2..-8]

intent_registry = {}

channel = require 'pubsub-js'

intent_names.forEach (name)->
  intents[name] = (params)->
    Intent = require("intents/#{name}")
    worker = new Intent
    worker.onmessage = ({data})->
      {name, params} = data
      channel.publish name, params

    worker.postMessage params

module.exports = intents
