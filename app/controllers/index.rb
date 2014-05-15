get '/' do
  # Look in app/views/index.erb
  @user = User.find(session[:user_id]) if session[:user_id] != nil
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

get '/:profile' do
  @user = User.find_by_username(params[:profile])
  if @user
    erb :profile
  else
    erb :error2
  end
end

post '/:profile/' do
end