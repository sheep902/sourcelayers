class BackgroundJob
  include Celluloid
  finalizer :cleanup

  def initialize(params)
    @store = $store.get_tx
    @params = params
  end

  attr_reader :store, :params

  def task
    raise 'override this method'
  end

  def results
    task
  ensure
    terminate
  end

  alias_method :call, :results

  def cleanup
    store.shutdown if $store
  end
end
