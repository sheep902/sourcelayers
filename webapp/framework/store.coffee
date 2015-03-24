Baobab = require 'baobab'
ReactAddons = require 'react/addons'

channel = require 'pubsub-js'

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

module.exports = store