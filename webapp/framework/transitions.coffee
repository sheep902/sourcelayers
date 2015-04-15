intents = {}

require.context('../intents', yes, /\.coffee$/).keys().map (name)-> name[2..-8]
  .forEach (name)-> intents[name] = require("intents/#{name}")

module.exports = intents
