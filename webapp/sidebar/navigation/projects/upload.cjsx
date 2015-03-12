React = require 'react'

TreeItem = require 'components/tree_item.cjsx'

module.exports = React.createClass
  render: ->
    <div className='projects'>
      <TreeItem icon='action-list' text='Projects' route={projects: 'index'}/>
    </div>
