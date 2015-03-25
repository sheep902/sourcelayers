{handler, store} = require 'framework/event'

handler 'signing_up', (username, password)->
  console.log 'signing_up', username, password
