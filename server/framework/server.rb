class Server < Angelo::Base
  post '/api/:command' do |c| # POST /api/command/ body: params
    content_type :json

    Command = App.all(:commands)[params[:command]]
    Command.new.exec params.except(:command)
  end

  get '/api' do |c| # GET /api?query=SELECT * FROM ...
    content_type :json

    Query.new.exec params[:query]
    # TODO eventsource
  end
end
