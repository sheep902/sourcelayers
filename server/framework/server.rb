class Server < Angelo::Base

  classes = -> (type) do
    type = type.to_s.pluralize
    base_path = "server/#{type}"

    names = Pathname.glob("#{base_path}/*.rb").map{ |name| name.basename '.*' }.map(&:to_s)
    names.map{ |name| name.classify.constantize }
  end

  # command handlers
  commands = classes.call :commands
  commands.each do |klass|
    post ['/api', klass.model, klass.command_name].join('/') do |c|

    end
  end

  queries = classes.call :queries
  queries.each do |klass|
    get ['/api', klass.query_name].join('/') do |c|

    end
  end

end
