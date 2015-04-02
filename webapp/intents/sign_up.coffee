{worker, transition} = require 'framework/intent'

worker (username, password)->
  xhr = new XMLHttpRequest()
  xhr.open 'GET', "/api/?type=user&name=#{username}", no
  xhr.send()
  xhr.response

