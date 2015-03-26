import com.tinkerpop.blueprints.impls.orient.OrientGraph

g = OrientGraph.new 'plocal:db/pacer'

# Schemas

g.create_vertex_type 'ProjectWatcher'

g.create_vertex_type 'Command'
g.create_vertex_type ''

g.create_vertex_type 'Query'
