class Query < Job
  def run(sql)
    result = DB.run sql
    puts result.to_a
    result.to_a
  end
end