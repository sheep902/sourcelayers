React = require 'react'

state = require 'lib/state'
data  = require 'lib/data'

module.exports =
  mixins: [state.mixin, data.mixin]
