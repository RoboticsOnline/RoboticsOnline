class FriendsController < ApplicationController
  def index
  	@users = User.all.where.not(last_request_at: nil).each do |u|
  		@test = (Time.now - u.last_request_at.to_time)/3600 
  	end
  end
end
