# DO NOT modify store in queries
store = require 'framework/store'

module.exports = (name, limit)->
  store.select('records', 'projects')