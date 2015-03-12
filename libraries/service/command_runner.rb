class Service::CommandRunner < Service
  trap_exit :on_error

  def initialize(id)
    @id = id
    @timer = every(HEARTBEAT_INTERVAL) { Celluloid::Actor[:heartbeat].alive! @id }
  end

  def run
    command = Command.find @id
    $pacer.tx { command[:status] == 'accepted' }

    runner_actor = command.actor
    link runner_actor
    runner_actor.run command.to_h

    command_finished
  end

  def command_finished
    $pacer.tx do
      c = Command.find @id
      c[:status] = 'ok'
    end
    terminate
  end

  def on_error(actor, reason)
    Celluloid::Actor[:logger].log @id, actor.to_s + ' terminated because ' + reason.to_s
    $pacer.tx do
      c = Command.find @id
      c[:status] = 'service_unavailable'
    end
    terminate
  end
end