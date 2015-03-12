# Client-side bootstrapping code
# Will add server-side rendering with Nashorn later

React = require 'react'
window.React = React

# required by material-ui
injectTapEventPlugin = require "react-tap-event-plugin"
injectTapEventPlugin();

# invariant.js
window.__DEV__ = false

Sourcelayers = require 'views/sourcelayers.cjsx'

router = require 'lib/router.coffee'

router.resources [
  'projects',
  'users',
  'info'
]

router.conflict [
  ['projects', 'users', 'info']
]

element = React.createElement Sourcelayers, route: router
ref = React.render(element, document.body)

router.root_component ref

Dispatcher = require('flux/lib/Dispatcher')
dispatcher = new Dispatcher()

window.app = module.exports =
  ref: ref

