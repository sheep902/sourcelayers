{handler, store} = require 'framework/event'

handler 'start_search', ->
  store.select('records', 'projects').set 'proj1', {name: 'bob'}
