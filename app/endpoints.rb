class Endpoints < Angelo::Base
  get '/api/query/:type' do
    content_type :json
    repo = (params[:type] + '_repo').classify.constantize.new
    repo.find params.reject(:type)
  end

  post '/api/commands/:name' do
    content_type :json
    repo = CommandRepo.new
    repo.create params[:name], params.reject(:name)
  end

  eventsource '/api/watch/:ids' do |s|
    ids = params[:ids].split(',')
    ids.map{ |id| sses[id] << s }
    s.on_close{ sses(false).remove_socket s }
  end

  get '*' do # catch-all
    'hello world'
  end

  task :record_updated do |id|
    sses[id].event :record_updated, id: id
  end
end
