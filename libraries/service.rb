class Service
  include Celluloid

  HEARTBEAT_INTERVAL = 5

  def run(props={})
    log props
  end

  def service_name
    self.class.name.underscore.gsub /_service$/, ''
  end
end

Service::ServiceLogger.supervise_as :logger
Service::Heartbeat.supervise_as :heartbeat
