React = require 'react'
Intention = require 'lib/intention.coffee'
Spinner = require 'components/spinner.cjsx'

module.exports = React.createClass
  mixins: [Intention]

  getInitialIntentions: ->
    command:
      query: 'commands'
      id: @props.id
      interval: 1000

  render: ->
    <div className='command-watcher'>
      <Spinner className='progress-spinner'/>
      <p className='status-text mui-font-style-subhead-1'>{@intentions.command.status()}</p>
    </div>
