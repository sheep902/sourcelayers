{element} = require 'framework/framework'

{div, p, search_button, tree} = require 'framework/elements'
{do_something} = require 'framework/intents'

module.exports = element
  search: ->
    do_something()

  render: ->
    div className: 'root',
      div className: 'navigation',
        div className: 'titlebar', 'title'
        tree {}, ''

      div className: 'main',
        'react'

      div className: 'histories',
        'world'

      search_button onClick: @search

