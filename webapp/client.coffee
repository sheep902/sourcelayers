# Client-side bootstrapping code
# Will add server-side rendering with Nashorn later
# sugar.js
require 'sugar'
Object.extend()

React = require 'react'
window.React = React

# required by material-ui
injectTapEventPlugin = require "react-tap-event-plugin"
injectTapEventPlugin();

# pubsub.js
PubSub = require 'pubsub-js'
PubSub.immediateExceptions = true;

Root = require 'components/root'

root = React.createElement Root

#require 'framework/debug'

document.addEventListener "DOMContentLoaded", ->
  root_div = document.getElementById('sourcelayers-root')
  React.render(root, root_div)

require 'styles/views.less'
