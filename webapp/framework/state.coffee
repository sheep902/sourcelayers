Baobab = require 'baobab'
ReactWithAddons = require 'react/addons'

module.exports = new Baobab
  records: {}
,
  mixins: [ReactWithAddons.PureRenderMixin]
  shiftReferences: true

