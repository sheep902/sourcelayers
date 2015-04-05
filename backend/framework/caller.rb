class Caller < BackgroundJob
  def task(command:, params)
    raise 'not a command' unless command.in? ['create_user']

    command = store.add_vertex "class:#{command}", params

    klass = command.classify.constantize
    klass.new.async.results params.merge(command: command)

    command
  end

  alias_method :call, :results
end