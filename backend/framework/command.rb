# TODO move orient-related codes to concern
class Command
  include Celluloid
  finalizer :cleanup

  attr_reader :store

  def initialize(params)
    @param = params
    @store = $store.get_tx
  end

  def schedule
  end

  def cleanup
    store.shutdown if $store
  end
end