get '/' do
  # Look in app/views/index.erb
  @message = params[:message]
  erb :index
end


get '/create' do
  erb :create
end

post '/create' do
  @user = User.create(params[:user])
  redirect '/?message=account%20created'
end