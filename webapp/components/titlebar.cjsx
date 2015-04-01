Component = require 'framework/component'

module.exports = Component
  cursors:
    main: 'main'

  render: ->
    <div className={"titlebar #{@props.className}"}>

    </div>