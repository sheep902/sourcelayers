require 'app'

class Server
  include Celluloid

  def initialize
    Endpoints.run
  end
end

Server.supervise_as(:server)
DBWatcher.supervise_as(:db_watcher)
sleep