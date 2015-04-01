Component = require 'framework/component'

module.exports = Component
  render: ->
    <div className={"tree-item #{@props.className}"}>
      tree-item
    </div>