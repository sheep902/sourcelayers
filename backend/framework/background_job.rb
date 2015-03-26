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

  def run(params)
    task params
  ensure
    terminate
  end

  def cleanup
    store.shutdown if $store
  end
end

