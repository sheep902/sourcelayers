import com.orientechnologies.orient.core.db.ODatabaseThreadLocalFactory
import com.orientechnologies.orient.core.db.OPartitionedDatabasePool

class AdminDatabaseFactory
  include ODatabaseThreadLocalFactory

  def initialize
    @pool = OPartitionedDatabasePool.new "plocal:#{DB::PATH}", 'admin', 'admin'
  end

  def getThreadDatabase
    @pool.acquire
  end
end

import com.orientechnologies.orient.core.Orient

admin_factory = AdminDatabaseFactory.new
Orient.instance.register_thread_database_factory admin_factory # TODO guest factory

at_exit { Orient.instance.shutdown }
