module Store
  def self.g
    graph = Pacer.orient 'db/pacer'
    graph.orient_graph.register_hook RecordUpdateHook.new
    graph
  end

end
