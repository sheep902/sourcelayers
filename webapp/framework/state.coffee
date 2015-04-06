Baobab = require 'baobab'
ReactAddons = require 'react/addons'

{handler} = require 'framework/transition'

state = new Baobab
  watching: []
  records: {}

  view: ''
  document: undefined
  history_list: undefined
,
  mixins: [ReactAddons.PureRenderMixin]
  shiftReferences: true

# Fetching

handler 'records', (records...)->
  records.map (record)->
    state.select('records').set(record.id, record) if record.id?

# Watching
current_watching = -> state.select('watching').get()

handler 'watch', (ids...)->
  ids.map (id)->
    unless id in current_watching()
      state.select('watching').push(id)

handler 'forget', (ids...)->
  state.set 'watching', current_watching().remove(ids)

evt_source = undefined

state.select('watching').on 'update', (params...)->
  evt_source?.close()

  query = state.select('watching').get().join(',')
  evt_source = new EventSource "http://localhost:4567/api/#{query}?sse=yes"
  evt_source.onmessage = (evt)->
    record = evt.data
    state.select('records').set record.id, record if record.id?

module.exports = state
