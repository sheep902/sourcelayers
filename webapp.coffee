require 'sugar'
Object.extend()

# params is a object
# doesn't work now.
Function::curry = (params)->
  func = this
  curried = params

  (params) ->
    deeply = yes
    func.call this, params.clone(deeply).merge(curried, deeply)

window.jQuery = window.$ = require 'jquery'

require 'is-in-viewport'
require 'jquery.scrollto'

require 'webapp/sourcelayers.less'
require 'webapp/client.coffee'