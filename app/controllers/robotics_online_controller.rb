class RoboticsOnlineController < ApplicationController
  def index
  	if current_user != nil
  		redirect_to user_path
  	end
  end
end
