Component = require 'framework/component'

module.exports = Component
  cursors:
    histories: 'histories'

  render: ->
    <div className={"histories #{@props.className}"}>
      <div className='history'/>
      <div className='history'/>
      <div className='history'/>
    </div>