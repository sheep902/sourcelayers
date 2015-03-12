class Service::ServiceLogger < Service
  def log(id, message)
    $redis_pool.with { |redis|
      redis.set id, message.to_json
    }
  end
end

