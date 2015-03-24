store = require 'framework/store'

module.exports = ->
  store.select 'records', 'projects'