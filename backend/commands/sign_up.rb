class SignUp < BackgroundJob
  def task(username:, password:, command:)
    store.add_vertex 'class:user', username: username, password: password
    store.get_vertex(command)[:status] = 'ok'
    store.commit
  end
end

