class Command
  def self.command_name
    name.underscore
  end

  def self.model
    nil
  end
end