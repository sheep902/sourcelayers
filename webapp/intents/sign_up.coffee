{worker, transition} = require 'framework/intent'
{command} = require 'framework/store'

worker (username, password)->
  transition 'signing_in', yes

  try
    command_vertex = command 'sign_up', username: username, password: password
    transition 'records', command_vertex
    transition 'watch', command_vertex.id
  finally
    transition 'signing_up', no
