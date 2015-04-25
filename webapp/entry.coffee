require 'material-ui' # material-ui doesn't work well with sugar.js
require 'framework/framework'

# required by material-ui
injectTapEventPlugin = require "react-tap-event-plugin"
injectTapEventPlugin();

{app} = require 'framework/elements'

React = require 'react'
document.addEventListener "DOMContentLoaded", ->
  root_div = document.getElementById('sourcelayers-root')
  React.render(app(), root_div)

require 'styles/styles'

