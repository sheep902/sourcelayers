{handler, emit} = require 'framework/command'

handler (username, password)->
  emit 'signing_up', username, password

