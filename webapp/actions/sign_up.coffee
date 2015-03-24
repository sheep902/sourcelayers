{handler, send_event} = require 'framework/action'

handler (username, password)->
  send_event 'signing_up'