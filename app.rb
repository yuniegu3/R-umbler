require 'sinatra'
require "sinatra/activerecord"


set :database, {adapter: 'postgresql', database: 'rumblerprojectdb'}
enable :sessions

# display home page 
get '/' do

end

# login page 
get '/login' do

end

# logout route, logs user out and redirects to homepage
get '/logout' do
    session.clear
    redirect '/'
end

#when user logs in
post '/user/login' do

end

#create new users
get '/user/signup' do

end
#create user
post '/user/new' do
    redirect '/'
end

#deletes user (have dependency - blog_id so that blog dies with user and post will die with blog)
delete '/user/:id' do
  
    redirect '/' #maybe i'll have a successfully deleted page here
end


# have users be able to added their own posts - specific post will be grabbed by id
get '/user/post/edit' do 
	erb :edit
end

# edit part for post, takes you back to homepage(maybe make it to link back to users blog that was edited?)
put '/user/post' do

    redirect '/'
end

#create post for user signed in
get '/user/post/create' do

end

#user created code - directs to home page but maybe direct to user blog
post '/user/post/new' do

    redirect '/'
end


delete '/user/post/:id' do

    redirect '/' ##maybe i'll have a successfully deleted page here 
end


#displays all posts in blog format for specific user - dont need to be logged in 
get '/blog/:id'

end

# displays specific blog by id..might need user_id fk along with post_id probably need a joined table search. - dont need to be logged in...
get '/blog/post/:id' do

end

# displays same tagged posts

get '/post/tags'

end

#create tag for user signed in (need to be signed in to tag posts)
get '/user/post/tags/tagit' do

end


# creates tag
post '/user/post/tags/new' do

    redirect '/'
end

#....do i really want a edit tags function?
