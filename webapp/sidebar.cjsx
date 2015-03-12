React = require 'react'
Paper = require('material-ui').Paper

Titlebar = require 'views/sidebar/titlebar.cjsx'
Toolbar = require 'views/sidebar/toolbar.cjsx'
Navigation = require 'views/sidebar/navigation.cjsx'

module.exports = React.createClass
  render: ->
    <div className='sidebar'>
      <Toolbar/>
      <Titlebar/>
      <Navigation/>
    </div>
