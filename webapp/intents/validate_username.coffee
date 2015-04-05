{worker, transition} = require 'framework/intent'

worker (username)->
  xhr = new XMLHttpRequest()
  xhr.open 'GET', "http://localhost:4567/api/?type=user&username=#{username}", no
  xhr.send()

  response = JSON.parse xhr.response
  existing_users = response['results']

  if existing_users.length
    transition 'username_duplicate'
  else
    transition 'username_available'
