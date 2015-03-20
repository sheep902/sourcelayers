React = require 'react'
p = React.createFactory 'p'

store = require 'truth/store'

module.exports = React.createClass
  mixins: [store.mixin]

  render: ->
    p null, [
      p null, 'hello'
      p null, 'world'
    ]
