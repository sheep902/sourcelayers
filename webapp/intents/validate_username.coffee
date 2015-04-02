{worker, transition} = require 'framework/intent'

worker (username)->
  xhr = new XMLHttpRequest()
  xhr.open 'GET', "/api/?type=user&name=#{username}", no
  xhr.send()

  existing_users = xhr.response

  if not existing_users or existing_users.isEmpty?()
    transition 'username_duplicate'
  else
    transition 'username_available'

