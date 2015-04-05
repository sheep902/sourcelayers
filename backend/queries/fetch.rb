class Fetch < BackgroundJob
  def task(ids)
    [*ids].map{ |id| store.get_vertex id }
  end
end