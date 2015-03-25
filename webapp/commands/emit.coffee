{handler} = require 'framework/command'

handler (evt_name, params)->
  emit params
