React = require 'react'
Router = require 'lib/router.coffee'
Whiteboard = require 'lib/whiteboard.coffee'

MUI = require 'material-ui'
FloatingActionButton = MUI.FloatingActionButton

Sidebar = require 'views/sidebar.cjsx'
Histories = require 'views/histories.cjsx'
Main = require 'views/main.cjsx'

module.exports = React.createClass
  componentDidMount: ->
    Router.init window.location.origin

  render: ->
    <div className='sourcelayers'>
      <Sidebar ref='sidebar'/>
      <Main ref='main'/>
      <FloatingActionButton icon="action-search" className='main-button'
       onTouchTap={->
         Whiteboard.write 'searching', true
       }/>
      <Histories ref='histories'/>
    </div>