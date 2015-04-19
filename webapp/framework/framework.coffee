# pubsub.js
PubSub = require 'pubsub-js'
PubSub.immediateExceptions = true;

in_worker = self.WorkerGlobalScope?

# monkey patches
require 'sugar'
Object.extend()

if in_worker
  module.exports =
    intent: (spec)->
      @onmessage = ({data})->
        try
          spec data
        finally
          close()
else
  Baobab = require 'baobab'
  ReactWithAddons = require 'react/addons'

  store = new Baobab
    records: {}
  ,
    mixins: [ReactWithAddons.PureRenderMixin]
    shiftReferences: true

  framework =
    element: (spec)->
      (spec.mixins ||= []).add store.mixin
      ReactWithAddons.createClass spec

    store: store

    intent: (spec)-> spec

    transition: (func)-> func

  module.exports = framework
