class Query < Job
  def run(sql)
    java_import com.orientechnologies.orient.core.sql.OCommandSQL
    sql = OCommandSQL.new sql

    store.command
  end
end