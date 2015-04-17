React = require 'react'

elements = {}

factory_generator = {}

# elements[name] = react factory

require.context('../elements', yes, /\.coffee$/).keys().map (name)-> name[2..-8]
  .forEach (name)->
    elements[name] = (params...)->

      factory_generator[name] ||= ->
        component = require "elements/#{name}"
        React.createFactory component

      factory_generator[name]() params

React.DOM.keys()
  .forEach (name)->
    elements[name] = React.createFactory name unless elements[name]?

module.exports = elements