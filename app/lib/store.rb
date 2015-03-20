class Store
  def self.connect
    return Thread.current[:store_connection] if Thread.current[:store_connection]
    graph = Pacer.orient 'db/pacer'
    graph.orient_graph.register_hook RecordUpdateHook.new
    Thread.current[:store_connection] = graph
  end
end

