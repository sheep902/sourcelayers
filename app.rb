require 'angelo'
require 'active_support/all'

LockJar.load

ActiveSupport::Dependencies.autoload_paths += %w(app/domains app/handlers app/lib app/repos)

require 'java'
