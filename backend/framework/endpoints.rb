class Endpoints < Angelo::Base
  get '/api/:ids' do
    content_type :json
    puts 'hit get'
    Fetch.new.results params.as_json.symbolize_keys[:ids]
  end

  get '/api/' do
    content_type :json
    puts 'hit search'
    Search.new.results params.as_json.symbolize_keys
  end

  put '/api/:command' do
    content_type :json
    Caller.new.call params.as_json.symbolize_keys
  end

  eventsource '/api/watch/:ids' do |s|
    ids = params[:ids].split(',')
    ids.map{|id| sses[id] << s}
    s.on_close{sses(false).remove_socket s}
  end

  task :update_record do |id|
    # sses[id].message FindById.new(id).results.as_json
  end

  get '/' do # catch-all
    File.read 'index.html' do |f| f.read end
  end
end
