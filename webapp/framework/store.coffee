# this file is shared by web workers and main thread
# so use plain javascript

search = (type, rules, callback=undefined)->
  xhr = new XMLHttpRequest()

  console.log rules

  query = Object.keys(rules).map((key)-> "#{key}=#{rules[key]}").join('&')

  xhr.open 'GET', "http://localhost:4567/api/?type=user&#{query}", document? # if in web worker, sync.
  xhr.onreadystatechange = callback
  xhr.send()

  JSON.parse(xhr.response)['results']

fetch = (ids...)->
  xhr = new XMLHttpRequest()

  callback = undefined
  callback = ids.pop() if ids.some (id)-> typeof id is 'function'

  query = ids.join(',')

  xhr.open 'GET', "http://localhost:4567/api/#{query}", document?
  xhr.onreadystatechange = callback
  xhr.send()

  JSON.parse(xhr.response)['results']

# backend prefer named parameters instead of parameter array
# e.g. {username: 'bob', password: 'alice'}
command = (command, params)->
  # commands are always triggered in intent workers
  xhr = new XMLHttpRequest()
  xhr.open 'POST', "http://localhost:4567/api/#{command}", no
  xhr.setRequestHeader 'Content-Type', 'application/json'
  xhr.send JSON.stringify(params)

  JSON.parse(xhr.response)

module.exports = {command, search, fetch}