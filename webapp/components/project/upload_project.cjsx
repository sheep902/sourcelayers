Component = require 'framework/component'

module.exports = Component
  upload: ->
    @intent 'upload_project', @refs.addr_input.getValue()

  render: ->
    <div className={"upload-project #{@props.className}"}>
      <div className='form-item'>
        <TextField hintText='Git Address' ref='addr_input'/>
      </div>
      <div className='form-item'>
        <RaisedButton label="Upload" primary={true} onClick={@upload}/>
      </div>
    </div>
