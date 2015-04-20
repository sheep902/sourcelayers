elements = {}

custom_factories = {}

# elements must be required in a lazy way because an element can require other elements

require.context('../elements', yes, /\.coffee$/).keys().map (name)-> name[2..-8]
  .forEach (name)->
    custom_factories[name] = ->
      component = require "elements/#{name}"
      React.createFactory component

    elements[name] = (params...)-> custom_factories[name]().apply this, params

React = require 'react'

React.DOM.keys()
  .forEach (name)->
    elements[name] = React.createFactory name unless elements[name]?

MUI = require 'material-ui'

MUI.keys().filter (key)-> MUI[key].isFunction()
  .map (name)->
    elements[name.underscore()] = React.createFactory MUI[name] unless elements[name]?

module.exports = elements
