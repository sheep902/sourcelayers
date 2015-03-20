Q = require 'q-xhr'


watch = (ids)-> # array of objects
  Q.xhr

query = (ids)-> # array of objects


search = (arguments)-> # array of ids


command = (name, arguments)-> # command id


module.exports =
  watch: watch
  query: query
  search: search
  command: command
