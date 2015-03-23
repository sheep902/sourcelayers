class Query
  include Celluloid
  finalizer :cleanup

  def initialize(param)
    @param = param
    @store = $store.get_no_tx # TODO protect it from accidental writes
  end

  attr_reader :store

  def result
  end

  def cleanup
    @store.shutdown if $store
  end
end
