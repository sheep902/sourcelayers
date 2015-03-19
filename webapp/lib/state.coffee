Baobab = require 'baobab'
data = require 'lib/data'

sse_handler = undefined

app_state = new Baobab
  main: undefined
  watching: []

app_state.select('watching').on 'update', (watching)->
  record_ids = watching.get()
  # update SSE connection

if window? && document?
  window.addEventListener 'popstate', => # update appstate.current

module.exports = app_state

