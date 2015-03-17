React = require 'react'
Router = require 'lib/router.coffee'

ListItem = require 'components/list_item.cjsx'

module.exports = React.createClass
  render: ->
    <div className='results'>
      {
        if @props.status in ['ok', 'not_modified']
          @props.projects.map (project, seq)=>
            style =
              order: seq
            <ListItem key={project.id} style={style} className='main-block result'
             name={project.remote} onClick={-> Router.goto projects: project.id}/>
        else if @props.status is 'not_found'
          <p>We can not find any project.</p>
      }
    </div>
