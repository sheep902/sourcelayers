class Services
  def self.[](name)
    Celluloid::Actor[name]
  end
end