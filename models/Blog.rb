class Blog < ActiveRecord::Base
	has_one :user, dependent: :destroy
	has_many :posts, dependent: :delete_all
end