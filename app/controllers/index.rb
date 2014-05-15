get '/' do
  # Look in app/views/index.erb
  @message = params[:message]
  erb :index
end

post '/' do
  @user = User.where(username: params[:username], password: params[:password]).first
  if @user
    session[:user_id]=@user.id
    redirect '/'
  else
    erb :error
  end
end

get '/create' do
  erb :create
end

post '/create' do
  @user = User.create(params[:user])
  redirect '/?message=account%20created'
end

post '/logout' do
  session.clear
  redirect '/'
end

post '/tweet' do
  Tweet.create(content: params[:tweet], user_id: session[:user_id] )
  redirect '/'
end