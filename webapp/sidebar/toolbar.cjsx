React = require 'react'
Router = require 'lib/router.coffee'

MUI = require 'material-ui'
IconButton = MUI.IconButton

module.exports = React.createClass
  render: ->
    <div className='toolbar'>
      <IconButton icon='action-home' tooltip='Main Page' className='button'
       onTouchTap={-> Router.goto projects: 'index'}/>
      <IconButton icon='action-history' tooltip='Histories' className='button'
       onTouchTap={-> Router.goto users: 'histories'}/>
      <IconButton icon='action-info-outline' tooltip='About' className='button'
       onTouchTap={-> Router.goto info: 'info'}/>
    </div>
