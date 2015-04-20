Promise = require 'bluebird'
{state} = require 'framework/framework'

xhr_promise = ({method, url, payload}) ->
  xhr = new XMLHttpRequest()

  return new Promise (resolve, reject)->
    xhr.addEventListener("error", reject)
    xhr.addEventListener("load", resolve)
    xhr.open("GET", url)
    xhr.send(payload)
  .cancellable().catch Promise.CancellationError, (e)->
    xhr.abort()
    throw e

API_URL = 'http://localhost:8080/api'

query = (name, params)->
  xhr_promise
    name: 'GET'
    url:  "#{API_URL}/#{name}?#{params.toQueryString()}"

command = (name, params)->
  xhr_promise
    name: 'POST'
    url:  "#{API_URL}/#{name}"
    payload: JSON.stringify(params)

event_source = undefined
watching_ids = []

update_sse = ->
  event_source?.close()
  event_source = new EventSource "#{API_URL}/#{watching_ids.join ','}"

  event_source.onmessage = ({data})-> state.select('records').set(data.id, data)

module.exports =
  command: (name, param)->
    command name, param

  search: (index, params)->
    query index, params

  fetch: (ids...)->
    query ids.join ','

  subscribe: (ids...)->
    watching_ids.add ids
    update_sse()

  unsubscribe: (ids...)->
    watching_ids.remove (id)-> id in ids
    update_sse()