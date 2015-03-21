class DBWatcher
  include Celluloid::Logger

  def tell(record)
    logger.info record # send SSEs
  end

end