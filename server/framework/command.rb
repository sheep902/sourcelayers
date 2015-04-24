class Command < Job
  def run(params)
    raise 'override this'
  end
end