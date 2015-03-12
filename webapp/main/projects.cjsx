React = require 'react'

Project = require 'views/main/projects/project.cjsx'
Index = require 'views/main/projects/index.cjsx'
Upload = require 'views/main/projects/upload.cjsx'

Router = require 'lib/router.coffee'

module.exports = React.createClass
  render: ->
    <div className='projects'>
      {
        switch Router.state().projects
          when 'index', undefined
            <Index/>
          when 'upload'
            <Upload/>
          else
            <Project/>
      }
    </div>
