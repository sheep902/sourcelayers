{worker, transition} = require 'framework/intent'

worker ->
  transition 'start_search'

