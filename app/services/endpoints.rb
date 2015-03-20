class Endpoints < Angelo::Base
  get '/api/search/' do
    content_type :json
    RequestHandler.new.search params
  end

  get '/api/reverse/:id' do
    content_type :json
    RequestHandler.new.reverse id
  end

  get '/api/:ids' do
    content_type :json
    RequestHandler.new.fetch params
  end

  put '/api/:id' do # commands should be idempotent
    content_type :json
    RequestHandler.new.async.command params

    halt 202, id: params[:id], status: 'submitted'
  end

  eventsource '/api/watch/:ids' do |s|
    ids = params[:ids].split(',')
    ids.map { |id| sses[id] << s }
    s.on_close { sses(false).remove_socket s }
  end
  task :update do |record|
    sses[id].message record
  end

  get '/*' do # catch-all
    'hello world'
  end
end
