require 'bcrypt'

class User < ActiveRecord::Base
	belongs_to :blog
	
	  # work on this shit
	include BCrypt
end






