class Caller < BackgroundJob
  def task(command:, **params)
    raise 'not a command' unless command.in? ['sign_up']

    command_vertex = store.add_vertex "class:#{command}", params
    store.commit

    klass = command.classify.constantize
    klass.new.async.results params.merge(command: command_vertex.id)

    command_vertex
  end

  alias_method :call, :results
end