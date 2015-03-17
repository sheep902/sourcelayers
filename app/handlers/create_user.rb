class CreateUser < Handler

  def run
    g = Store.g
    params = g.vertex(@command_id, CommandRepo).params

    g.tx{
      g.create_vertex(type: 'user', username: params[:username], password: params[:password])
      self[:status] = 'finished'
    }
  end

end