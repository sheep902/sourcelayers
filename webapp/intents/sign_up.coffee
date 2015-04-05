{worker, transition} = require 'framework/intent'

worker (username, password)->
  xhr = new XMLHttpRequest()
  xhr.open 'POST', "http://localhost:4567/api/", no
  xhr.send()



