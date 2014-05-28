class RoboticsOnlineController < ApplicationController
	def index
		if current_user != nil
			if current_user.admin.nil?
				redirect_to user_path
			else 
				redirect_to admin_path
			end
		end
	end
  
end
