class RanklistController < ApplicationController
  def index
  	@first_state_users = User.all
  	@users = @first_state_users.sort_by {|obj| obj.robot.level}.reverse!
    @@current_page = 1
    @page = 1
  end

  def sort_by
  	@first_state_users = User.all
  	@by = params[:by]
    @page = 1	
	case @by
		when "Level"
  			@users = @first_state_users.sort_by {|obj| obj.robot.level}.reverse!
  		when "Username"
  			@users = @first_state_users.sort_by {|obj| obj.username}
  		when "Battles"
  			@users = @first_state_users.sort_by {|obj|  
				Battle.where(:robot_id => obj.robot.id).count + Battle.where(:oponent_id => obj.robot.id).count
			}.reverse!
  		when "Battles_Won"
  			@users = @first_state_users.sort_by {|obj|  
				Battle.find_all_by_winner(obj.username).count
			}.reverse!
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

  def page
    @@current_page = params[:id].to_i
    @page = params[:id].to_i
    @first_state_users = User.all
    if @by == nil
        @second_state_users = @first_state_users.sort_by {|obj| obj.robot.level}.reverse!  
    else 
        case @by
            when "Level"
                @second_state_users = @first_state_users.sort_by {|obj| obj.robot.level}.reverse!
            when "Username"
                @second_state_users = @first_state_users.sort_by {|obj| obj.username}
            when "Battles"
                @second_state_users = @first_state_users.sort_by {|obj| 
					Battle.where(:robot_id => obj.robot.id).count + Battle.where(:oponent_id => obj.robot.id).count
				}.reverse!
            when "Battles_Won"
                @second_state_users = @first_state_users.sort_by {|obj| Battle.find_all_by_winner(obj.username).count}.reverse!
            when "Battles_Lost"
                @second_state_users = @first_state_users.sort_by {|obj|  
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
    end

    @third_state_users = @second_state_users.last(@second_state_users.count - (params[:id].to_i - 1)*20)
    @users = @third_state_users.first(20)

  end
end
