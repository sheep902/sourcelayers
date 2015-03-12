React = require 'react'
Paper = require('material-ui').Paper

MUI = require 'material-ui'
IconButton = MUI.IconButton

module.exports = React.createClass
  render: ->
    <div className='histories'>
      <div className='titlebar'>
        <IconButton className="add-history-button" icon="content-add-box" tooltip="Add Bookmark"/>
      </div>
    </div>
