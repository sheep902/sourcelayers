class BackgroundJob
  include Celluloid
  finalizer :cleanup

  def initialize
    @store = $store.get_tx
  end

  attr_reader :store

  def task(params)
    raise 'override this method'
  end

  def results(params)
    task(params)
  ensure
    terminate
  end

  alias_method :call, :results

  def cleanup
    store.shutdown if $store
  end
end
