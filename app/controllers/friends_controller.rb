class FriendsController < ApplicationController
  	def index
  		@users = User.all.where.not(last_request_at: nil).each do |u|
  			@time = (Time.now - u.last_request_at.to_time)/3600 
  		end

  		if current_user.friends.count < 20
  			@random = @users.shuffle.first(20 - current_user.friends.count)
  		else 
  			@random = @users.shuffle.first(current_user.friends.count)
  		end
  	end
end
