# Java dependencies
require 'lock_jar'

LockJar.lock
LockJar.install
LockJar.load

# Ruby dependencies
require 'angelo'
require 'active_support/all'
require 'celluloid/autostart'

ActiveSupport::Dependencies.autoload_paths += Dir.glob 'backend/*/'

# environment variables
require 'backend/store/startup'

# monkey patches
require 'backend/store/orient_vertex'

# services

# server
Celluloid::Actor[:server] = Endpoints.run
at_exit do Celluloid::Actor[:server].terminate end