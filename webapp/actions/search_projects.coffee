channel = require 'pubsub-js'

channel.subscribe 'search_projects', (name)->
