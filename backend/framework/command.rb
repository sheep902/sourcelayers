class Command
  include Celluloid
  finalizer :cleanup

  def initialize(params)
    @param = params
    @store = $store.get_tx
  end

  attr_reader :store

  def schedule
  end

  def cleanup
    @store.shutdown if $store
  end
end