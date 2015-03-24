React = require 'react'
div = React.createFactory 'div'

classnames = require 'classnames' # TODO

module.exports = React.createClass
  render: ->
    div {className: classnames('sidebar', @props.className)}, [
      'hello world'
    ]