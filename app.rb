require 'sinatra'
require "sinatra/activerecord"
require 'bcrypt'

require_relative 'models/blog'
require_relative 'models/post'
require_relative 'models/user'
require_relative 'models/tag'
require_relative 'models/post_tag'

#set :database, {adapter: 'postgresql', database: 'rumblerdb'}
enable :sessions

# display home page 
get '/' do
	@users = User.all
	#checking if user is rendering, should give me all users
	# @yblog = Blog.where(user_id: 1)
	# # should give me blog by test
	# @tblog = Blog.where(user_id: 2)
	# # should give me all post by blog yunie via blog_id 1
	# @yposts = Post.where(blog_id: 1).all
	# # should give me all post by blog test via blod id 2
	# @tposts = Post.where(blog_id: 2).all
	# #show all tags
	# @tags = Tag.all
	# # should give me all posts with tag 2 from both yunie blog and test blog 
	# x = Post_tag.where(tag_id:2)
	# @y = x.pluck(:post_id)

	#there must be another way to do this...maybe Tag.where(id:2).posts but this donest work...i thought it would but nope!

	erb :index
end
# login page 
get '/user/login' do
	erb :login
end

# logout route, logs user out and redirects to homepage
get '/logout' do
    session.clear
    redirect '/'
end

#when user logs in brings up profile page for logged in user
post '/user/login' do 
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user != nil
        session[:id] = @user.id
        redirect '/user/:id/profile'
    else   
        #Could not find this user. Redirecting them to the  home page
        @errormsg = "Error occured, please make sure your email and password is correct. If you do not have a account with us, please sign up first."
        erb :error 
    end 
end

#if user does not have a blog, will force user to create it.
get '/user/:id/profile' do
	@user = User.find(session[:id])
	if Blog.find_by(user_id: @user.id) != nil
		erb :profile
else
		redirect '/user/blog/create'
end
end

#create new users
get '/signup' do
	erb :new_user

end

#create user 
post '/user/new' do
	all_users = User.all
	 if all_users.find_by(email: params[:email]) == nil
	 	User.create(first_name: params[:first_name], last_name: params[:last_name], password: params[:password], email: params[:email], birth_date: params[:birth_date])
	 redirect '/user/login'
	else
		@errormsg = "Error occured, please make sure you are not already registered with your email."
		 erb :error 
    end
end

#edit user, user can edit their profile
get '/user/:id/edit' do
	@user = User.find(session[:id])
    erb :edit_user
end

# edits the User data with w/e user editted.
put '/user/:id' do
   @user = User.find(session[:id]) 
   @user.update(first_name: params[:first_name], last_name: params[:last_name], password: params[:password], birth_date: params[:birth_date])
   erb :profile
end


#deletes user (have dependency - blog_id so that blog dies with user and post will die with blog)
delete '/user/:id' do
  	@user = User.find(session[:id]) 
  	@user.destroy
  	session.clear
    erb :deleted #maybe i'll have a successfully deleted page here
end

#User can edit blog name
get '/user/blog/:id/edit' do
	@user = User.find(session[:id]) 
	@blog = Blog.find_by(user_id: @user.id)
	erb :edit_blog
end

put '/user/blog/' do
	@user = User.find(session[:id]) 
	@blog = Blog.find_by(user_id: @user.id)
	@blog.update(user_id: @user.id , blog_name: params[:blog_name])
	redirect '/user/blog/myblog'
end

#creates user blog - user can only make 1 blog, no need to make delete for blog.
get '/user/blog/create' do
	erb :new_blog
end

#create blog
post '/user/blog/new' do
	@user = User.find(session[:id])
	Blog.create(user_id: @user.id , blog_name: params[:blog_name])
	redirect '/user/blog/myblog'

end

#user blog site - gives error when user does not have posts and trys to go :my_blog_post...now that I think about it,
#this could of worked with if/else statement in :my_blog/:my_blog_post so that @posts is made only when post exists
#and in the :my_blog the @posts is only used if it exists. I will still need if statement here but it is doable with 
# 1 erb page.
get '/user/blog/myblog' do
	@user = User.find(session[:id]) 
	@blog = Blog.find_by(user_id: @user.id)
	if Post.where(blog_id:@blog.id) == 0
		erb :my_blog
	end
	if Post.where(blog_id:@blog.id) != 0
		@posts = Post.where(blog_id:@blog.id)
		erb :my_blog_post

end
end

# have users be able to edit their own posts - specific post will be grabbed by id
get '/user/post/:post/edit' do
	@user = User.find(session[:id]) 
	@blog = Blog.find_by(user_id: @user.id)
	@posts = Post.find(params[:post])
	erb :edit_post
end

# edit part for post, takes you back to user blog
put '/user/post/:post' do
	@user = User.find(session[:id])
	@blog = Blog.find_by(user_id: @user.id)
	@posts = Post.find(params[:post])
	@posts.update(blog_id: @blog.id, post_name: params[:post_name], content: params[:content])
    redirect '/user/blog/myblog'
end

#create post for user signed in
get '/user/post/create' do
	erb :new_post
end

#user created post - direct to user blog
post '/user/post/new' do
	@user = User.find(session[:id])
	@blog = Blog.find_by(user_id: @user.id)
	Post.create(blog_id: @blog.id , post_name: params[:post_name], content: params[:content])
    redirect '/user/blog/myblog'
end


delete '/user/post/:post' do
	@user = User.find(session[:id])
	@blog = Blog.find_by(user_id: @user.id)
	@posts = Post.find(params[:post])
	@posts.destroy
    redirect '/user/blog/myblog' ##maybe i'll have a successfully deleted page here 
end



#create tag for user signed in (need to be signed in to tag posts)
get '/user/post/:post/tags/tagit' do

	@user = User.find(session[:id])
	@blog = Blog.find_by(user_id: @user.id)
	@posts = Post.find(params[:post])

erb :new_tag
end

# creates tag
post '/user/post/:post/tags/new' do
	@user = User.find(session[:id])
	@blog = Blog.find_by(user_id: @user.id)
	@posts = Post.find(params[:post])
	Tag.create(tag_name: params[:tag_name])
	@tag = Tag.find_by(tag_name: params[:tag_name])
	Post_tag.create(post_id: @posts.id, tag_id: @tag.id)

    redirect '/user/blog/myblog'
end

# edit tag route
get '/user/posts/:post/tags/:tag/edit' do
	@user = User.find(session[:id])
	@blog = Blog.find_by(user_id: @user.id)
	@posts = Post.find(params[:post])
	@tag = Tag.find(params[:tag])
	erb :edit_tag
end

#edit tag - can only change tag name.
put '/user/posts/:post/tags/:tag' do
	@user = User.find(session[:id])
	@blog = Blog.find_by(user_id: @user.id)
	@posts = Post.find(params[:post])
	@tag = Tag.find(params[:tag])
	@tag.update(tag_name: params[:tag_name])
	redirect '/user/blog/myblog'
end

#delete tag
delete '/user/posts/:post/tags/:tag/delete' do
	@user = User.find(session[:id])
	@blog = Blog.find_by(user_id: @user.id)
	@posts = Post.find(params[:post])
	@tag = Tag.find(params[:tag])
	@post_tag = Post_tag.find_by(tag_id: @tag.id, post_id: @posts.id)
	@post_tag.destroy
	@tag.destroy
	redirect '/user/blog/myblog'
end

# no need for log in.

#displays all posts  - dont need to be logged in  - post mvp maybe limit to how many posts show up?
# maybe get a tab thingy working os its like 100 posts in 1 page.
get '/blogs/posts' do
	@posts = Post.all

	erb :all_posts
end

#displays all tags

get '/blog/posts/tags' do
	@all_tags = Tag.all
	erb :show_tags
end

# displays all same tagged posts

get '/blogs/posts/tags/:tag' do
	@specific_tag = Tag.find(params[:tag])
	x = Post_tag.where(tag_id: params[:tag])
	@y = x.pluck(:post_id)
	erb :show_posts_by_tag
end






# post mvp- how can i make it so that when user create post, user has options to tag while making post?
# comments

