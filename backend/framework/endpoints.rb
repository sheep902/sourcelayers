class Endpoints < Angelo::Base
  get '/api/:ids' do
    content_type :json
    Query.new(params).run
  end

  put '/api/:id' do
    content_type :json
    Command.new(params).async.run
    {id: params[:id], status: 'submitted'}
  end

  eventsource '/api/watch/:ids' do |s|
    ids = params[:ids].split(',')
    ids.map{|id| sses[id] << s}
    s.on_close{sses(false).remove_socket s}
  end

  task :update_record do |id|
    query = FindById.new(id)
    sses[id].message query.result.as_json
    query.terminate
  end

  get '/*' do # catch-all
    'hello world'
  end
end
