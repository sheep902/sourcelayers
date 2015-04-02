class FindById < Query
  def query
    store.get_vertex params
  end
end