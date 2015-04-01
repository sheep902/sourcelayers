Component = require 'framework/component'
TreeItem = require 'components/tree/tree_item'

module.exports = Component
  cursors:
    main: 'main'

  render: ->
    <div className={"tree #{@props.className}"}>
      <TreeItem/>
    </div>
