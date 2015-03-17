React = require 'react'
Intention = require 'lib/intention.coffee'

CommandWatcher = require 'components/command_watcher.cjsx'
Header = require './upload/header.cjsx'
Form = require './upload/form.cjsx'

module.exports = React.createClass
  mixins: [Intention]

  upload_repo: (name, remote)->
    @setIntention 'upload_repo', command: 'upload_repo', name: 'name', remote: remote

  render: ->
    <div className='upload'>
      <Header status={@intentions.upload_repo?.status()}/>
      {
        upload_status = @intentions.upload_repo?.status()
        switch upload_status
          when undefined, 'conflict', 'error'
            <Form upload={@upload_repo}/>
          when 'created'
            <CommandWatcher id={@intentions.upload_repo?.payload().id}/>
      }
    </div>
