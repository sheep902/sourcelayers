Baobab = require 'baobab'

data_store = new Baobab
  users: {}
  projects: {}
  files: {}
  commands: {}
  histories: {}
  workspaces: {}
  docblocks: {}

module.exports = data_store
