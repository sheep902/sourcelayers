{element} = require 'framework/framework'
{div, p} = require 'framework/elements'

module.exports = element
  render: ->
    div {},
      p {},
        'hello world'
      p {},
        'hello react'
