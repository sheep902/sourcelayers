import com.tinkerpop.blueprints.impls.orient.OrientGraph

import com.orientechnologies.orient.core.metadata.schema.OType

g = OrientGraph.new 'plocal:db/pacer'
index_manager = g.raw_graph.metadata.index_manager

# Schemas

g.create_vertex_type 'command'

g.create_vertex_type 'user'

ut = g.get_vertex_type 'user'

ut.create_property 'username', OType::STRING
ut.create_property 'password', OType::STRING


