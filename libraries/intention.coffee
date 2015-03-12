# WIP
# License: Mozilla Public License, version 2.0

xhr = require 'xhr'
stringify = require 'json-stable-stringify'

status_codes = require './status_codes.coffee'

# TODO do we need GC ?

identify = (params)->
  stringify params

member = (content)=>
  if content then '/' + content  else ''

query = (content)=>
  if content and not content.equals {} then '?' + content.toQueryString() else ''

class Intention
  # command: 'upload_repo' / query: 'projects'
  # other parms
  constructor: (@params)->
    @id = identify @params

    mode = if @params['command']
      'command'
    else
      'query'
    type = @params[mode]
    id = @params['id']
    body = if mode is 'command' then @params.reject 'command'  else undefined
    search = if mode is 'query' then @params.reject 'query', 'id' else undefined

    @constructor.values[@id] ||=
      status:  'pending'
      payload: undefined

    @constructor.connections[@id] ||= xhr
      uri: @constructor.root_uri + member(mode) + member(type) + member(id) + query(search)
      method: {command: 'post', query: 'get'}[mode]
      json: body
    , (e, response)=>
      value =
        status:  status_codes[response?.statusCode] || 'error'
        payload: response.body

      delete @constructor.connections[@id]

      unless value.equals @constructor.values[@id]
        @constructor.values[@id] = value
        @constructor.listeners[@id].each (component) -> component.forceUpdate()

  notify: (component)->
    components = @constructor.listeners[@id] ||= []
    components.push component unless component in components
    @

  forget: (component)->
    components = @constructor.listeners[@id] ||= []
    components.remove component

    connection = @constructor.connections[@id]

    if components.isEmpty()
      connection?.abort()
      delete @constructor.connections[@id]

  value: ->
    @constructor.values[@id]

  # helper methods
  status: ->
    @value().status
  payload: ->
    @value().payload

  #----------

  id: undefined

  # id -> connections
  @connections: {}

  # id -> components
  @listeners: {}

  # id -> {status: 'status', payload: object}
  @values: {}

  @root_uri: '/api'

Intentions = # react.js component mixin

  # @intentions.projects?.value().status
  # @intentions.projects?.value().payload
  intentions: {}

  timers: {}

  setIntention: (name, params)->
    existing = @intentions[name]

    if existing?
      existing.forget(this)

    @intentions[name] = (new Intention(params)).notify(@)

  setStreaming: (interval, name, params)->
    clearTimeout @timers[name] if @timers[name]
    delete @timers[name]

    update_loop = =>
      return if @intentions[name]?.status() is 'ok'
      @setIntention(name, params)
      @timers[name] = setTimeout(update_loop, interval)

    update_loop()

  componentWillMount: ->
    intention_params = (@['getInitialIntentions']?() || {})
    intention_params.map (name, params) =>
      if params.interval?
        @setStreaming params['interval'], name, params.reject('interval')
      else
        @setIntention name, params

  componentWillUnmount: ->
    @timers.each (name, timer)->
      cleanTimeout timer
      delete timer[name]
    @intentions.each (_, intention)-> intention.forget(@)

module.exports = Intentions

# Usage:
# Intention = require 'intention.coffee'
#
# component = React.createClass
#   mixins: [Intention]
#   project: (name)->
#     @setIntention 'project_intention', query: 'projects', name: name
#   render:
#     <p>{@intentions.project_intention?.status()}</p>
#     <p>{@intentions.project_intention?.payload()}</p>
