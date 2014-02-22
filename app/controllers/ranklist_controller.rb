class RanklistController < ApplicationController
  def index
  	@first_state_users = User.all
  	@users = @first_state_users.sort_by {|obj| obj.robot.level}.reverse!
  end
  def sort_by
  	@first_state_users = User.all
  		
	case params[:by]
		when "Level"
  			@users = @first_state_users.sort_by {|obj| obj.robot.level}.reverse!
  		when "Username"
  			@users = @first_state_users.sort_by {|obj| obj.username}
  		when "Battles"
  			@users = @first_state_users.sort_by {|obj|  Battle.where(:robot_id => obj.robot.id).count + Battle.where(:oponent_id => obj.robot.id).count}.reverse!
  		when "Battles_Won"
  			@users = @first_state_users.sort_by {|obj|  Battle.find_all_by_winner(obj.username).count}.reverse!
  		when "Battles_Lost"
  			@users = @first_state_users.sort_by {|obj|  
  				@battles = Battle.where(:robot_id => obj.robot.id) + Battle.where(:oponent_id => obj.robot.id)
  				lost = 0
  				@battles.each do |b| 
  					if b.winner != obj.username
  						lost += 1
  					end
  				end
          lost
  			}.reverse!

  	end
  
  	respond_to do |format|
		format.js
	end
  end
end
