React = require 'react'
Router = require 'lib/router.coffee'

MUI = require 'material-ui'
Icon = MUI.Icon

TouchRipple = require 'material-ui/src/js/ripples/touch-ripple.jsx'
FocusRipple = require 'material-ui/src/js/ripples/focus-ripple.jsx'

Router = require 'lib/router.coffee'

module.exports = TreeItem = React.createClass

  click: ->
    return unless @props.route?
    Router.goto @props.route

  render: ->
    <div className={'tree-item '+@props.className}>
      <div className='item' onMouseOver={@props.focus} onClick={@click}>
        <Icon className='icon' icon={@props.icon}/>
        <div className='text'>{@props.text}</div>
      </div>
      {
        if @props.opening
          <div className='children'>
          {
            @props.children()
          }
          </div>
      }
    </div>

