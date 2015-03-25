View = require 'framework/view'

module.exports = View
  render: ->
    <div className = {@props.className}>
      hello react
    </div>
