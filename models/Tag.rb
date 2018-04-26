class Tag < ActiveRecord::Base
	# has_many :post_tags
	# has_many :posts, through: :post_tags
	has_and_belongs_to_many :posts
end