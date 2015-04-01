Baobab = require 'baobab'
ReactAddons = require 'react/addons'

channel = require 'pubsub-js'

state = new Baobab
  watching: []

  view: ''
  document: undefined
  history_list: undefined
,
  mixins: [ReactAddons.PureRenderMixin]
  shiftReferences: true

window.state = state if window?

module.exports = state