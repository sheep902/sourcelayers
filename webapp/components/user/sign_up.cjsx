Component = require 'framework/component'

TextField = require('material-ui').TextField
RaisedButton = require('material-ui').RaisedButton

require 'styles/user/sign-up'
module.exports = Component
  transitions:
    'username_duplication': (is_duplicate)-> @setState username_duplicate: is_duplicate

  sign_up: ->
    @intent 'sign_up',
      username: @refs.name_input.getValue()
      password: @refs.psw_input.getValue()

  validate_username: (change_evt)->
    username = change_evt.target.value
    @cancel_all 'validate_username'
    @intent 'validate_username', username

  render: ->
    <div className={"sign-up #{@props.className}"}>
      <div className='form-item'>
        <TextField hintText='User Name' ref='name_input' onChange={@validate_username}
         errorText={if @state.username_duplicate then 'Username already exist.' else ''}/>
      </div>
      <div className='form-item'>
        <TextField hintText='Password' ref='psw_input'/>
      </div>
      <div className='form-item'>
        <RaisedButton label="Sign Up" primary={true} onClick={@sign_up}
         disabled={
           [@state.username_duplicate].any (error)-> error is yes
         }
        />
      </div>
    </div>
