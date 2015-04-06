global.React = require 'react'

# monkey patches
require 'sugar'
Object.extend()

Worker.prototype.close = ->
  @onmessage = undefined
