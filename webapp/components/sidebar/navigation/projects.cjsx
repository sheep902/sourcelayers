React = require 'react'
Router = require 'lib/router.coffee'

Upload = require './projects/upload.cjsx'

TreeItem = require 'components/tree_item.cjsx'

module.exports = React.createClass
  render: ->
    <div className='projects'>
    {
      switch Router.state().projects
        when 'upload'
          <Upload/>
        else
          <TreeItem icon='file-cloud-download' text='Clone Repository' route={projects: 'upload'}/>
    }
    </div>
