
class Job
  include Celluloid

  trap_exit :close_store

  def store
    DB.open
  end

  def run(params)
    raise 'please override this'
  end

  def exec(params)
    begin
      run params
    ensure
      terminate
    end
  end

  def close_store
    DB.close
  end
end