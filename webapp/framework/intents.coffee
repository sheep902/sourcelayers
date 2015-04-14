require.context('../intents', yes, /\.coffee$/).keys()
  .map (name)-> name[2..-8]
  .forEach (name)->
    elements[name] = (params...)->
      intent = require("intents/#{name}")


