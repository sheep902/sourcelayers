require 'framework/framework'

# required by material-ui
injectTapEventPlugin = require "react-tap-event-plugin"
injectTapEventPlugin();

{test} = require 'framework/elements'

React = require 'react'
document.addEventListener "DOMContentLoaded", ->
  root_div = document.getElementById('sourcelayers-root')
  React.render(test(), root_div)
