module Kernel
  import com.tinkerpop.blueprints.impls.orient.OrientGraphFactory
  import com.orientechnologies.orient.core.Orient

  FACTORY = OrientGraphFactory.new('plocal:db/orient').setup_pool(10, 10000)
  at_exit do
    FACTORY.close
    Orient.instance.shutdown
  end

  Orient.instance.add_db_lifecycle_listener UpdateTrigger.new

  def store
    opening_graph = Thread.current[:orient_graph]
    return opening_graph if opening_graph.present?

    graph = FACTORY.get_tx
    Thread.current[:orient_graph] = graph
  end
end

