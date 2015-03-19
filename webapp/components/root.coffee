Component = require 'component'

React = require 'react'
p = React.createFactory 'p'

module.exports = React.createClass
  mixins: [Component]

  render: ->
    p null, [
      p null, 'hello'
      p null, 'world'
    ]
