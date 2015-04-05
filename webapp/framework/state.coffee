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

current_watching = -> state.select('watching').get()

handler 'fetch', (ids...)->


handler 'watch', (ids...)->
  ids.map (id)->
    unless id in current_watching()
      state.select('watching').push(id)

handler 'unwatch', (ids...)->
  state.set 'watching', current_watching().remove(ids)

state.select('watching').on 'update', (params...) -> console.log params # update EventSource

module.exports = state
