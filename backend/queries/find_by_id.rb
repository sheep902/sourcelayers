class FindById < Query
  def result
    @store.get_vertex @param
  end
end