class Post_tag < ActiveRecord::Base
	belongs_to :Post
	belongs_to :tag
end