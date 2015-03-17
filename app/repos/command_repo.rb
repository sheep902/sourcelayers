class CommandRepo
  include Celluloid

  def create(name, params)
    g = Store.g

    command = g.tx{
      command = g.create_vertex self.class, type: 'command', name: name, status: 'submitted'
      params = g.create_vertex params
      g.create_edge nil, command, params, :params
      command
    }
    command.call

    command
  end

  def find(params)

  end

  module Vertex
    include Repo::Record

    def call
      g = Store.g
      g.tx{ self[:status] = 'running' }

      command_executor = self[:name].classify.constantize.new getId
      command_executor.async.run
    end

    def params
      out_edges(:params).first
    end
  end

end