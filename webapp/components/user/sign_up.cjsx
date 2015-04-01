Component = require 'framework/component'

TextField = require('material-ui').TextField
RaisedButton = require('material-ui').RaisedButton

require 'styles/user/sign-up'
module.exports = Component
  render: ->
    <div className={"sign-up #{@props.className}"}>
      <div className='form-item'>
        <TextField hintText='User Name' ref='name_input'/>
      </div>
      <div className='form-item'>
        <TextField hintText='Password' ref='psw_input'/>
      </div>
      <div className='form-item'>
        <RaisedButton label="Sign Up" primary={true}/>
      </div>
    </div>