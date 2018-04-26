class Post < ActiveRecord::Base
	# has_many :post_tags
	# has_many :tags, through: :post_tags
	has_and_belongs_to_many :tags
	belongs_to :blog
end