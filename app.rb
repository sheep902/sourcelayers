require 'angelo'
require 'active_support/all'

require 'lock_jar'
LockJar.load

ActiveSupport::Dependencies.autoload_paths += %w(app/domains app/handlers app/lib app/repos app)

require 'java'
