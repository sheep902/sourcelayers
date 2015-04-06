# Client-side bootstrapping code
# Will add server-side rendering with Nashorn later
# sugar.js
require 'env'

# required by material-ui
injectTapEventPlugin = require "react-tap-event-plugin"
injectTapEventPlugin();

# pubsub.js
PubSub = require 'pubsub-js'
PubSub.immediateExceptions = true;

Root = require 'components/root'
root = React.createElement Root
document.addEventListener "DOMContentLoaded", ->
  root_div = document.getElementById('sourcelayers-root')
  React.render(root, root_div)

require 'styles/views.less'
