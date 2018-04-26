class CreatePosts < ActiveRecord::Migration[5.2]
  def change
  	 	create_table :posts do |t|
  		t.integer :blog_id
  		t.string :post_name
  		t.longtext :content
  	end
  end
end
