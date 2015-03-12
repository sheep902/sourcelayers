React = require 'react'
Initial = require 'components/initial.cjsx'
MUI = require 'material-ui'
Icon = MUI.Icon

module.exports = ListItem = React.createClass
  render: ->
    # TODO unwrap Initial component
    <div className={'' + @props.className + ' list-item-component'} style={@props.style}
      onClick={@props.onClick}>
      <div className='avatar'>
          <Initial name={@props.name} size={40}/>
      </div>
      <span className='name'>{@props.name}</span>
    </div>