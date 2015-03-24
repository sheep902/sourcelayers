React = require 'react'

sidebar = React.createFactory require('components/root/sidebar')

store = require 'framework/store'

module.exports = React.createClass
  mixins: [store.mixin]

  render: ->
    sidebar className: 'sidebar'
