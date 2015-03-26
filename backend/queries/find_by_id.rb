class FindById < Query
  def query
    store.get_vertex @param
  end
end