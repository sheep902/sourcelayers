import com.orientechnologies.orient.core.hook.ORecordHookAbstract
import com.orientechnologies.orient.core.db.ODatabaseLifecycleListener

class UpdateTrigger < ORecordHookAbstract
  include ODatabaseLifecycleListener

  import com.orientechnologies.orient.core.hook.ORecordHook.HOOK_POSITION

  def onOpen(db)
    db.register_hook(self, HOOK_POSITION::LAST)
  end

  def onCreate(db)
    db.register_hook(self, HOOK_POSITION::LAST)
  end

  def onClose(db)
    db.unregister_hook(self)
  end

  def getPriority
    import com.orientechnologies.orient.core.db.ODatabaseLifecycleListener.PRIORITY
    PRIORITY::LAST
  end

  def onRecordAfterUpdate(r)
    watcher = Celluloid::Actor[:db_watcher]
    if watcher and watcher.alive?
      watcher.async.tell r.getIdentity
    end
  end

  def getDistributedExecutionMode
    import com.orientechnologies.orient.core.hook.ORecordHook.DISTRIBUTED_EXECUTION_MODE
    DISTRIBUTED_EXECUTION_MODE::BOTH
  end

  def onCreateClass(i_database, i_class)
    #code here
  end

  def onDropClass(i_database, i_class)
    #code here
  end

  # onRecordUpdateReplicated
end
