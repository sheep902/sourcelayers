channel = require 'pubsub-js'

channel.subscribe 'transition', (name, params)->
  console.log "#{name} #{params}"

