React = require 'react'

MUI = require 'material-ui'
TextField = MUI.TextField
FlatButton = MUI.FlatButton
Spinner = require 'components/spinner.cjsx'

Intention = require 'lib/intention.coffee'

module.exports = React.createClass
  mixins: [Intention]

  submit: ->
    @props.upload @refs.name_input.getValue(), @refs.remote_input.getValue()

  check_conflict: (address)->
    @setIntention 'conflict', query: 'projects', remote: address

  render: ->
    <div className='form'>
      <TextField ref='name_input' floatingLabelText='Name' className='form-item'
       hintText='How do people refer to this project?'/>

      <TextField ref='remote_input' floatingLabelText='Address' className='form-item'
       errorText={if @intentions.conflict?.status() is 'ok' then 'already exists' else undefined}
       hintText='Cloneable Git address, or GitHub user/repo pair.'
       onChange={(e)=> @check_conflict(e.target.value)}/>
      {<Spinner/> if @intentions.conflict?.status() is 'pending'}

      <FlatButton label='upload' primary={true} onTouchTap={@submit}
       className='main-block form-item submit-button'/>
    </div>
