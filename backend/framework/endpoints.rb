class Endpoints < Angelo::Base
  get '/api/' do
    content_type :json
    Search.new.results params.as_json.symbolize_keys
  end

  get '/api/:ids' do
    content_type :json
    Get.new.results params.as_json.symbolize_keys[:ids]
  end

  eventsource '/api/watch/:ids' do |s|
    ids = params[:ids].split(',')
    ids.map{|id| sses[id] << s}
    s.on_close{sses(false).remove_socket s}
  end

  # get '/api/:ids/[query name]' do
  #
  # end

  put '/api/:id' do
    content_type :json
    Command.factory(params.clone).async.call
    {id: params[:id], status: 'submitted'}
  end

  task :update_record do |id|
    # sses[id].message FindById.new(id).results.as_json
  end

  get '/' do # catch-all
    File.read 'index.html' do |f| f.read end
  end
end
