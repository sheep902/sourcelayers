React = require 'react'
Store = require 'framework/store'

module.exports =
  element: (spec)->
    (spec.mixins ||= []).add Store.mixin
    React.createClass spec
