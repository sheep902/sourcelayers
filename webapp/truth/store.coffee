Baobab = require 'baobab'
ReactAddons = require 'react/addons'

store = new Baobab
  records:
    users: {}
    projects: {}
    files: {}
    commands: {}
    histories: {}
    workspaces: {}
    docblocks: {}

  watching: []

  states:
    view: ''
    document: undefined
    history_list: undefined
,
  mixins: [ReactAddons.PureRenderMixin]
  shiftReferences: true

listener = undefined

watching_cursor = store.select('watching')

watching_cursor.on 'update', ->
  watching_ids = watching_cursor.get()

  listen = ->
    try
      listener.close
    finally
      listener = undefined

    return if watching_ids.isEmpty()

    listener = new EventSource '/api/watch/' + watching_ids.join(',')

    listener.onmessage (evt)->
      payload = JSON.parse evt.data
      type = payload['type']
      id = payload['id']

      store.select(type).edit(id: payload)

    listener.onerror ->
      if listener.readyState is 2
        setTimeout listen, 5000

  listen()

if window? && document?
#  window.addEventListener 'beforeunload', (e) ->
#    localStorage.state = JSON.stringify store
#  , no;
  window.addEventListener 'popstate', => # update store

module.exports = store
