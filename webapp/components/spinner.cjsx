React = require 'react'

module.exports = React.createClass
  render: ->
    <div className={'spinner-component ' + @props.className}>
      <div className="loader">loader</div>
    </div>

