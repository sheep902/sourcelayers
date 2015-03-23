# Client-side bootstrapping code
# Will add server-side rendering with Nashorn later
window.jQuery = window.$ = require 'jquery'

require 'is-in-viewport'
require 'jquery.scrollto'

React = require 'react'
window.React = React

# required by material-ui
injectTapEventPlugin = require "react-tap-event-plugin"
injectTapEventPlugin();

# invariant.js
window.__DEV__ = false

Root = require 'components/root'

root = React.createElement Root

# register action handlers
require 'actions/search_projects'

$(document).ready ->
  root_div = $('#sourcelayers-root').get(0)
  React.render(root, root_div)

require 'styles/root.less'
