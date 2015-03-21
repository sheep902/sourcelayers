class CreateUser < Command
  def call
  end

  def param_list
    [:username, :password]
  end
end