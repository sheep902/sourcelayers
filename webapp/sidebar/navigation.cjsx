React = require 'react'
Whiteboard = require 'lib/whiteboard.coffee'
Router = require 'lib/router.coffee'

Projects = require './navigation/projects.cjsx'
Users = require './navigation/users.cjsx'

module.exports = React.createClass
  scroll_left_to: (dom_element)->
    $(@getDOMNode()).scrollTo(dom_element, 50, axis: 'x')

  render: ->
    <div className='navigation'>
    {
      switch Router.root()
        when 'users'
          <Users/>
        else
          <Projects/>
    }
    </div>
