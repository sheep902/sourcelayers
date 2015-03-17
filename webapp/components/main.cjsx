React = require 'react'

Projects = require 'views/main/projects.cjsx'
Users = require 'views/main/users.cjsx'

Router = require 'lib/router.coffee'
Whiteboard = require 'lib/whiteboard.coffee'

module.exports = React.createClass
  render: ->
    <div className='main'>
    {
      switch Router.root()
        when 'users'
          <Users/>
        when 'info'
          <p>info</p>
        else
          <Projects/>
    }
    </div>
