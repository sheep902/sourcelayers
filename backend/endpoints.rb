class Endpoints < Angelo::Base
  get '/api/query/' do
    content_type :json
    Query.search params
  end

  get '/api/:ids' do
    content_type :json
    Query.fetch params
  end

  put '/api/:id' do # commands should be idempotent
    content_type :json
    Command::Dispatcher.dispatch params

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
