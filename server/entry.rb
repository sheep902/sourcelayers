require 'lock_jar'

LockJar.lock
LockJar.install
LockJar.load

require 'angelo'
require 'active_support/all'
require 'celluloid/autostart'

ActiveSupport::Dependencies.autoload_paths += Dir.glob 'server/*/'
