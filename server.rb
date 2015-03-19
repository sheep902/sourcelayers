require 'app'

class Server
  include Celluloid

  def initialize
    Endpoints.run
  end
end

Server.supervise_as(:server)
sleep