Component = require 'framework/component'

TextField = require('material-ui').TextField
RaisedButton = require('material-ui').RaisedButton

require 'styles/user/sign-up'
module.exports = Component
  sign_up: ->
    @intent 'sign_up',
      username: @refs.name_input.getValue()
      password: @refs.psw_input.getValue()

  render: ->
    <div className={"sign-up #{@props.className}"}>
      <div className='form-item'>
        <TextField hintText='User Name' ref='name_input'/>
      </div>
      <div className='form-item'>
        <TextField hintText='Password' ref='psw_input'/>
      </div>
      <div className='form-item'>
        <RaisedButton label="Sign Up" primary={true} onClick={@sign_up}/>
      </div>
    </div>
