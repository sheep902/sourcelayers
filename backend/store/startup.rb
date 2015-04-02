import com.tinkerpop.blueprints.impls.orient.OrientGraphFactory
import com.orientechnologies.orient.core.Orient

$store = OrientGraphFactory.new('plocal:db/orient')

$store.setup_pool 1, 2000

at_exit do
  $store.close
  $store = nil
  Orient.instance.shutdown
end

Orient.instance.add_db_lifecycle_listener UpdateTrigger.new
