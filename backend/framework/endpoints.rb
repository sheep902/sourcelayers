class Endpoints < Angelo::Base
  def params
    super.as_json.symbolize_keys
  end

  get '/api/:ids' do
    content_type :json
    ids = params[:ids].split(',')
    Fetch.new.results ids
  end

  eventsource '/api/:ids' do |s|
    ids = params[:ids].split ','

    sse_keys = ids.map{ |id| id.gsub ':', '_' }.map(&:to_sym)
    sse_keys.map{ |id| sses[id] << s }
    s.on_close{sses(false).remove_socket s}

    s.message Fetch.new.results(ids).to_json
  end

  get '/api/' do
    content_type :json
    Search.new.results params
  end

  post '/api/:command' do
    content_type :json
    Caller.new.call params
  end

  task :update_record do |id|
    sse_key = id.gsub(':', '_').to_sym
    record = Fetch.new.results(id).as_json
    sses[sse_key].message record.first unless record.empty?
  end

  get '/' do # catch-all
    File.read 'index.html' do |f| f.read end
  end

end
