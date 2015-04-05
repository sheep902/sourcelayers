{worker, transition} = require 'framework/intent'
{search} = require 'framework/store'

worker (username)->
  existing_users = search 'user', username: username

  if existing_users.length
    transition 'username_duplication', yes
  else
    transition 'username_duplication', no
