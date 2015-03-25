# DO NOT modify store in queries
store = require 'framework/store'

module.exports = ->
  store.select 'records', 'projects'