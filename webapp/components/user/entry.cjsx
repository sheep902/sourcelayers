Component = require 'framework/component'

TextField = require('material-ui').TextField
RaisedButton = require('material-ui').RaisedButton

module.exports = Component
  transitions:
    'username_exists': (exists)-> @setState 'username_exists', exists
    'user_signed_in': (user)-> @intent 'open_user', user
    'user_entry_failed': (error)-> @setState 'working', no

  sign_up: ->
    @setState 'working', yes
    @intent 'sign_up', @refs.name_input.getValue(), @refs.psw_input.getValue()

  sign_in: ->
    @setState 'working', yes
    @intent 'sign_in', @refs.name_input.getValue(), @refs.psw_input.getValue()

  validate_username: (change_evt)->
    username = change_evt.target.value
    @cancel_all 'validate_username'
    @intent 'validate_username', username

  render: ->
    <div className={"entry #{@props.className}"}>
      <div className='form-item'>
        <TextField hintText='User Name' ref='name_input' onChange={@validate_username}
         errorText={if @state.username_exists then 'Username already exist.' else ''}/>
      </div>
      <div className='form-item'>
        <TextField hintText='Password' ref='psw_input'/>
      </div>

      {
        if @state.username_duplicate
          <div className='form-item'>
            <RaisedButton label="Sign In" secondary={true} onClick={@sign_in}
             disabled={
               [@state.username_exists].any (condition)-> condition is no
             }
            />
          </div>
        else
          <div className='form-item'>
            <RaisedButton label="Sign Up" primary={true} onClick={@sign_up}
             disabled={
               [@state.username_exists].any (error)-> error is yes
             }
            />
          </div>
      }

    </div>
