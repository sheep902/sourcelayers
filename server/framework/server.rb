class Server < Angelo::Base
  post '/api/:command' do |c| # POST /api/command/ body: params
    Command = App.all(:commands).fetch(params[:command])
    Command.new.exec(params.except :command)
  end

  get '/api' do |c| # GET /api?query=SELECT * FROM ...
    sql = params[:query]
    Query.new.exec(sql)
    # TODO eventsource
  end
end
