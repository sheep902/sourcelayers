React = require 'react'
Store = require 'framework/store'

elements = {}

custom_elements = {}

# custom_element_names
require.context('../elements', yes, /\.coffee$/).keys()
  .map (name)-> name[2..-8]
  .forEach (name)->
    elements[name] = (params...)->
      element = require("elements/#{name}")
      custom_elements[name] ||= (->
        obj = {}

        obj.render = element.markup
        obj.cursors = element.store
        obj.mixins = [Store.mixin]

        # internal state
        # props translation

        React.createFactory React.createClass(obj)
      )()
      custom_elements[name].apply undefined, params

React.DOM.keys()
  .forEach (name)->
    elements[name] = React.createFactory name unless elements[name]?

module.exports = elements
