require 'angelo'
require 'active_support/all'

require 'lock_jar'

LockJar.lock
LockJar.install
LockJar.load

ActiveSupport::Dependencies.autoload_paths += %w(app/models app/handlers app/lib app/services)

module App
  def self.[](name)
    Celluloid::Actor[name]
  end
end

require 'java'
