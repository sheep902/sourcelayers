# Intent
# Intents are 

intents = {}

intent_names = require.context('../intents', yes, /\.coffee$/).keys().map (name)-> name[2..-8]

intent_names.forEach (name)->
  intents[name] = (params)->
    intent = require "intents/#{name}"
    intent params

module.exports = intents
