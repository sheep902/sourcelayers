{element} = require 'framework/framework'
{div, p} = require 'framework/elements'
{do_something} = require 'framework/intents'

module.exports = element
  handle_click: ->
    do_something 'something'

  render: ->
    div onClick: @handle_click,
      p {},
        'hello world'
      p {},
        'hello react'
