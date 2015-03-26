# Client-side bootstrapping code
# Will add server-side rendering with Nashorn later
# sugar.js
require 'sugar'
Object.extend()

NODE_ENV = 'development'

React = require 'react'
window.React = React

# required by material-ui
injectTapEventPlugin = require "react-tap-event-plugin"
injectTapEventPlugin();

# register events
require 'events/signing_up'
require 'events/start_search'

Root = require 'views/root'

root = React.createElement Root

document.addEventListener "DOMContentLoaded", ->
  root_div = document.getElementById('sourcelayers-root')
  React.render(root, root_div)

require 'styles/views.less'
