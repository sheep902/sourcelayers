PubSub = require 'pubsub-js'
PubSub.immediateExceptions = true;

require 'sugar'
Object.extend()

React = require 'react'
Bluebird = require 'bluebird'

state = require 'framework/state'

framework =
  element: (spec)->
    (spec.mixins ||= []).add state.mixin
    React.createClass spec

  intent: Bluebird.method

  event: (func)-> func

module.exports = framework
