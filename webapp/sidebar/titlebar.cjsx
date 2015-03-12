React = require 'react'

MUI = require 'material-ui'
Router = require 'lib/router.coffee'

module.exports = React.createClass
  render: ->
    <div className='titlebar logo-title'>
      <img className='logo' src='/favicon.ico'/>
      <div className='text'>
        <div className='name'>
          sourcelayers
        </div>
        <div className='description'>
          A code reading software.
        </div>
      </div>
    </div>
