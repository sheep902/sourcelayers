{element} = require 'framework/framework'
{div} = require 'framework/elements'

module.exports = element
  cursors: ['tree', 'scroll']
  render: ->
    div {},
      'tree'
