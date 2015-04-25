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

query = (sql)->
  xhr_promise
    name: 'GET'
    url:  "#{API_URL}?params=#{sql.escapeURL(true)}"

command = (name, params)->
  xhr_promise
    name: 'POST'
    url:  "#{API_URL}/#{name}"
    payload: JSON.stringify(params)

API = {}

commands = require 'sketch/commands'

commands.forEach (name)->
  API[name] = (params)-> command name, params

API.query = query

module.exports = API
