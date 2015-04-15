React = require 'react'
Store = require 'framework/store'

elements = {}

custom_elements = {}

require.context('../elements', yes, /\.coffee$/).keys().map (name)-> name[2..-8]
  .forEach (name)->
    elements[name] = (params...)->
      custom_elements[name] ||= ->
        spec = require "elements/#{name}"
        (spec.mixins ||= []).add Store.mixin
        React.createFactory React.createClass(spec)
      custom_elements[name]().apply undefined, params

React.DOM.keys()
  .forEach (name)->
    elements[name] = React.createFactory name unless elements[name]?

module.exports = elements