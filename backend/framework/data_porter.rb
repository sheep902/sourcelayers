class DataPorter
  include Celluloid
  finalizer :cleanup

  attr_reader :store

  def initialize(vertex)
    @vertex = vertex
    @store = $store.get_tx
  end

  def act
    raise 'not implemented'
  end

  def cleanup
    store.shutdown if $store
  end

end