class Command
  include Celluloid
  finalizer :cleanup

  attr_reader :store

  def initialize(params)
    @param = params
    @store = $store.get_tx
  end

  def run
    @store.add_vertex # TODO

  end

  def cleanup
    store.shutdown if $store
  end
end