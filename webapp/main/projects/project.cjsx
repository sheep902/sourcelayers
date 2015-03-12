React = require 'react'

Router = require 'lib/router.coffee'
Intention = require 'lib/intention.coffee'

ListItem = require 'components/list_item.cjsx'


module.exports = React.createClass
  mixins: [Intention]

  getInitialIntentions: ->
    project:
      query: 'projects'
      id: router.state()['projects']

  render: ->
    <div className='project main'>
      {console.log @intentions.project?.payload()}
    </div>

