class CreatePostTags < ActiveRecord::Migration[5.2]
  def change
  	 	create_table :post_tags do |t|
  		t.integer :post_id
  		t.integer :tag_id
  	end
  end
end


class CreatePosts < ActiveRecord::Migration[5.2]
  def change
  	 	create_table :posts do |t|
  		t.integer :blog_id
  		t.string :post_name
  		t.string :content
  	end
  end
end


class CreateTags < ActiveRecord::Migration[5.2]
  def change
  	 create_table :tags do |t|
  	 	t.string :tag_name
  	end
  end
end


class CreateBlogs < ActiveRecord::Migration[5.2]
  def change
  	 	create_table :blogs do |t|
  		t.integer :user_id
  		t.string :blog_name
  	end
  end
end


class CreateUsers < ActiveRecord::Migration[5.2]
  def change
  	create_table :users do |t|
  		t.string :first_name
  		t.string :last_name
  		t.integer :password #look up secure?
  		t.string :email
  		t.date :birth_date
  	end
    end
end





<!-- 
<div>
	<p>Give me Post info for 2nd Tag</p>
	<% @displaypost.each do |tagged| %>
	<p> <%= tagged.post_name  %> </p>
	<p> <%= tagged.blog_id %> </p>
	<p> <%= tagged.content %> </p>
	<% end %>
	
</div> -->



<p> name :<%= Post.find_by (id: post).post_name %></p>
	<p> blog id: <%= Post.find_by (id: post).blog_id %> </p>
	<p> post content: <%= Post.find_by (id: post).content %> </p>
