Baobab = require 'baobab'
ReactAddons = require 'react/addons'

module.exports = new Baobab
  records: {}
,
  mixins: [ReactAddons.PureRenderMixin]
  shiftReferences: true