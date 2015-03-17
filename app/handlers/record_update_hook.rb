class RecordUpdateHook < com.orientechnologies.orient.core.hook.ORecordHookAbstract
  def onRecordAfterUpdate(r)
    server = Celluloid::Actor[:server]
    if server and server.alive?
      server.async.record_updated r.getIdentity
    end
  end

  # onRecordUpdateReplicated
end