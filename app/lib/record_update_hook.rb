import com.orientechnologies.orient.core.hook.ORecordHookAbstract


class RecordUpdateHook < ORecordHookAbstract

  def onRecordAfterUpdate(r)
    server = Celluloid::Actor[:server]
    if server and server.alive?
      server.async.update r.getIdentity
    end
  end

  # onRecordUpdateReplicated
end