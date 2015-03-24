import com.orientechnologies.orient.core.hook.ORecordHookAbstract
import com.orientechnologies.orient.core.db.ODatabaseLifecycleListener

class UpdateTrigger < ORecordHookAbstract
  include ODatabaseLifecycleListener

  import com.orientechnologies.orient.core.hook.ORecordHook

  def onOpen(db)
    db.register_hook(self, ORecordHook::HOOK_POSITION::LAST)
  end

  def onCreate(db)
    db.register_hook(self, ORecordHook::HOOK_POSITION::LAST)
  end

  def onClose(db)
    db.unregister_hook(self)
  end

  def getPriority
    com.orientechnologies.orient.core.db.ODatabaseLifecycleListener::PRIORITY::LAST
  end

  def onRecordAfterUpdate(r)
    server = Celluloid::Actor[:server]

    if server and server.alive?
      Celluloid::Actor[:server].async.update_record r.get_identity.to_s
    end
  end

  def getDistributedExecutionMode
    import com.orientechnologies.orient.core.hook.ORecordHook
    ORecordHook::DISTRIBUTED_EXECUTION_MODE::BOTH
  end

  def onCreateClass(i_database, i_class)
    #code here
  end

  def onDropClass(i_database, i_class)
    #code here
  end

  # onRecordUpdateReplicated
end
