
get '/' do
  # Look in app/views/index.erb
  session[:user_id] ||= nil
  @user = User.find(session[:user_id]) if session[:user_id] != nil
  @message = params[:message]
  erb :index
end

post '/' do
  session[:message] = ""
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
  if @user.id == nil
    @message = @user.errors.full_messages[0]
  else
    @message = "Account created"
  end
  session[:message] = @message
  redirect "/?#{@message}"
end

post '/logout' do
  session[:user_id] = nil
  redirect '/'
end

post '/tweet' do
  Tweet.create(content: params[:tweet], user_id: session[:user_id] )
  redirect '/'
end

post '/:profile' do
  follow_id = User.find_by_username(params[:profile]).id
  p session[:user_id]
  user = User.find(session[:user_id]).id
  Follow.create(user_id: user, follow_id: follow_id)
  redirect "/#{params[:profile]}"
end

get '/:profile' do
  @user = User.find_by_username(params[:profile])
  if @user
    erb :profile
  else
    erb :error2
  end
end

get '/:username/following' do
  @user = User.find_by_username(params[:username])
  erb :following
end

get '/:username/followers' do
  @user = User.find_by_username(params[:username])
  @followers = followers(@user)
  erb :followers
end

post '/:username/favorites' do
  Favorite.create(user_id: session[:user_id], tweet_id: params[:tweet_id] )
  redirect "/#{params[:username]}"
end

get '/:username/favorites' do
  @user_favorites=Favorite.where(user_id: session[:user_id])
  erb :favorites
end