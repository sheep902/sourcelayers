{worker, transition} = require 'framework/intent'
{search} = require 'framework/store'

worker (username)->
  existing_users = search 'user', username: username

  transition 'username_exists', existing_users.length
