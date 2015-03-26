class ProjectTransporter
  include Celluloid
  finalizer :cleanup

  attr_reader :vertex
  attr_reader :store

  def initialize(vertex)
    @vertex = vertex
    @store = $store.get_tx
  end

  def fetch(name)

  rescue
    terminate
  end

  def cleanup
    vertex[:status] = 'exception'
    store.shutdown if $store
  end
end