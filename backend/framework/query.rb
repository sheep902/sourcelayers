class Query
  include Celluloid
  finalizer :cleanup

  attr_reader :store

  def initialize(param)
    @param = param
    @store = $store.get_no_tx # TODO protect it from accidental writes
  end

  def result
  end

  def cleanup
    store.shutdown if $store
  end
end
