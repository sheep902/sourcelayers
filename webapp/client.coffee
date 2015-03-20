# Client-side bootstrapping code
# Will add server-side rendering with Nashorn later
window.jQuery = window.$ = require 'jquery'

require 'is-in-viewport'
require 'jquery.scrollto'

#require './components/sourcelayers.less'

React = require 'react'
window.React = React

# required by material-ui
injectTapEventPlugin = require "react-tap-event-plugin"
injectTapEventPlugin();

# invariant.js
window.__DEV__ = false

Root = require 'components/root'

root = React.createElement Root

$(document).ready ->
  root_div = $('#sourcelayers-app').get(0)
  React.render(root, root_div)

require 'stylesheets/root.less'
