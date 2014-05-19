get '/' do
  # Look in app/views/index.erb
  @message = params[:message]
  erb :index
end

post '/' do
  session[:message] = ""
  @user = User.where(username: params[:username], password: params[:password]).first
  if @user
    session[:user_id] = @user.id
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
  # you might be better off rendering instead of redirecting and setting the
  # message in an instance variable instead of the session.
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

post '/search' do
  search(h(params[:search]))
  erb :results
end

get '/update' do
  erb :update
end

put '/update' do
  user = User.find(session[:user_id])
  user.update_attributes(params[:user])
  # user.save         update_attributes automatically saves.
  redirect "/#{params[:username]}"
end

get '/:profile' do
  @user = User.find_by_username(params[:profile])
  if @user
    erb :profile
  else
    erb :error2
  end
end

post '/:profile' do
  Follow.create(user_id: current_user,
                follow_id: User.find_by_username(params[:profile]))
  redirect "/#{params[:profile]}"
end

get '/:username/favorites' do
  @user_favorites = Favorite.where(user_id: session[:user_id])
  erb :favorites
end

# a more restful route would be delete '/favorites/:tweet_id'
delete '/favorites' do
  # This code works however is not optimal because it searches thru the join table.
  Favorite.where(user_id: session[:user_id], tweet_id: params[:tweet_id]).first.destroy
  redirect "/#{current_user.name}/favorites"
end

delete '/:following' do
  Follow.where(user_id: current_user, # ActiveRecord should intelligently know to use the ID in this case
               follow_id: User.find_by_name(params[:following])).first.destroy
  redirect "/#{params[:following]}"
end


get '/:username/following' do
  @user = User.find_by_username(params[:username])
  erb :following
end

get '/:username/followers' do
  @user = User.find_by_username(params[:username])
  erb :followers
end

post '/:username/favorites' do
  Favorite.create(user_id: session[:user_id], tweet_id: params[:tweet_id] )
  redirect "/#{params[:username]}"
end



