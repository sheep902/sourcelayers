# Client-side bootstrapping code
# Will add server-side rendering with Nashorn later
require 'sugar'
Object.extend()

window.jQuery = window.$ = require 'jquery'

require 'is-in-viewport'
require 'jquery.scrollto'

require './components/sourcelayers.less'

React = require 'react'
window.React = React

# required by material-ui
injectTapEventPlugin = require "react-tap-event-plugin"
injectTapEventPlugin();

# invariant.js
window.__DEV__ = false

Sourcelayers = require './components/sourcelayers.cjsx'

element = React.createElement Sourcelayers, route: router

root = $('#sourcelayers-app')
ref = React.render(element, root)

window.app = module.exports =
  ref: ref

