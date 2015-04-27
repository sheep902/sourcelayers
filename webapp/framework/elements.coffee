elements = {}

# elements must be required in a lazy way because an element can require other elements

React = require 'react'

require.context('../elements', yes, /\.coffee$/).keys().map (name)-> name[2..-8]
  .forEach (name)->
    lazy_factory = (name)->
      component = require "elements/#{name}"
      React.createFactory component
    elements[name] = (params...)-> lazy_factory(name).apply this, params

React.DOM.keys()
  .forEach (name)->
    elements[name] = React.createFactory name

MUI = require 'material-ui'

MUI.keys().filter (key)-> MUI[key].isFunction()
  .forEach (name)->
    elements[name.underscore()] = React.createFactory MUI[name]

module.exports = elements
