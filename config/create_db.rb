require 'lock_jar'
LockJar.load

import com.tinkerpop.blueprints.impls.orient.OrientGraph

import com.orientechnologies.orient.core.metadata.schema.OType

g = OrientGraph.new 'plocal:db/orient'

# Schemas

g.create_vertex_type 'command'
g.create_vertex_type 'params'

g.create_vertex_type 'user'
g.create_vertex_type 'history'
g.create_vertex_type 'history_list'

g.create_vertex_type 'project'
g.create_vertex_type 'directory'
g.create_vertex_type 'file'
g.create_vertex_type 'scope'


ut = g.get_vertex_type 'user'
ut.create_property 'username', OType::STRING
ut.create_property 'password', OType::STRING
ut.create_index 'user.username', 'unique', 'username'

at_exit do
  g.shutdown
end