class UserController < ApplicationController
  	def index
  		if current_user == nil
  			redirect_to root_path
  		else
  			@battles = Battle.find_all_by_robot_id(current_user.robot.id) + Battle.find_all_by_oponent_id(current_user.robot.id)
  		end
 	end

 	def show 
 		@user = User.find_by_username(params[:username])
 		if @user == current_user 
 			redirect_to user_path
 		end
  		@battles = Battle.find_all_by_robot_id(@user.robot.id) + Battle.find_all_by_oponent_id(@user.robot.id)
 	end

	def battlefield
		#tuk shte ima 2 snimki 1 vs 2 kato v tetradkata 
		#kato ako nqma nishto shte ima kartinka s "?" i pri klik shte te prehvarlq vav fight
		if params[:id].nil?
			if not params[:username].nil?
				@user = User.find_by_username(params[:username])
			end
		else 
			@mob = Mob.find(params[:id])
		end
		
	end

	def get_consumables
		if current_user.resource.gold >= 30 
			if params[:consumable] == "Electricity"
				current_user.resource.electricity += 100
			else 
				if params[:consumable] == "Oil"
					current_user.resource.oil += 50
				else
					current_user.robot.current_health = current_user.robot.max_health
					current_user.robot.save
				end
			end
			current_user.resource.gold -= 30
			current_user.resource.save
			
			respond_to do |format|
				format.js
			end
		end
	end

	def main_battle 
		if params[:oponent] == "Mob"
			oponent_stat = Mob.find(params[:id]).stat	
			oponent_health = (oponent_stat.stamina - 33) * 30 + 1000	
			current_user.resource.electricity -= 30
		else 
			oponent_stat = Robot.find(params[:id]).stat
			oponent_health = Robot.find(params[:id]).current_health
			current_user.resource.electricity -= 40
		end
		current_user.resource.save
		combat_log = ""

		current_user_special_attack = 0
		oponent_special_attack = 0
		current_user_mana = (current_user.robot.stat.intelligence - 20)*5 + 100
		oponent_mana = (oponent_stat.intelligence - 20)*5 + 100
		attack_turn = 1
		i = 0
		while current_user.robot.current_health > 0 && oponent_health > 0 do
			hit = 0
			i += 1
			if attack_turn == 1
				attack_turn = 2
				if current_user.resource.oil > 2
					current_user.resource.oil -= 2
					current_user.resource.save
					hit = rand((current_user.robot.stat.attack/2)..(current_user.robot.stat.attack))
				else 
					if current_user.resource.electricity > 4
						current_user.resource.electricity -= 4
						current_user.resource.save
						hit = rand((current_user.robot.stat.attack/2)..(current_user.robot.stat.attack))
					end
				end
				if current_user_special_attack == 3
					if current_user_mana >= 20 
						hit += current_user.robot.stat.strength*2
						current_user_mana -= 20
					end
					current_user_special_attack = 0
				else 
					current_user_special_attack += 1
				end
				if  rand(100) <= (current_user.robot.stat.agility - 18)*0.29 + 5.14
					hit = (hit*1.5).to_i
					crit = true		
				end
				if hit > oponent_stat.armor/2 
					hit -= oponent_stat.armor/2
				end
				if rand(100) <= (oponent_stat.defence/30).to_i
					hit = 0
					block = true
				end
				if block 
					combat_log += "#{current_user.username} missed\n"
					block = false
				else 
					if crit
						combat_log += "#{current_user.username} CRIT with un amount of: #{hit.to_s} damage\n"
						crit = false
					else 
						combat_log += "#{current_user.username} whitehited with un amount of #{hit.to_s} damage\n"
					end
				end
				oponent_health -= hit
			else 
				attack_turn = 1
				if params[:oponent] == "Robot"
					u = User.find(Robot.find(params[:id]).user_id)
					if u.resource.oil > 2
						u.resource.oil -= 2
						u.resource.save
						hit = rand((oponent_stat.attack/2)..(oponent_stat.attack))
					else 
						if u.resource.electricity > 4
							u.resource.electricity -= 4
							u.resource.save
							hit = rand((oponent_stat.attack/2)..(oponent_stat.attack))
						end
					end
					if oponent_special_attack == 3
						if oponent_mana >= 20 
							hit += oponent_stat.strength*2
							oponent_mana -= 20
						end
						oponent_special_attack = 0
					else 
						oponent_special_attack += 1
					end
					if rand(100) <= (oponent_stat.agility - 18)*0.29 + 5.14
						hit = (hit*1.5).to_i 
						crit = true
					end
					if hit > current_user.robot.stat.armor/2
						hit -= current_user.robot.stat.armor/2
					end
					if rand(100) <= (current_user.robot.stat.defence/30).to_i
						hit = 0 
						block = true
					end
					if block 
						combat_log += "#{u.username} missed\n"
							block = false
					else 
						if crit
							combat_log += "#{u.username} CRIT with un amount of: #{hit.to_s} damage\n"
							crit = false
						else 
							combat_log += "#{u.username} whitehited with un amount of #{hit.to_s} damage\n"
						end
					end
					current_user.robot.current_health -= hit
				else
					hit = rand((oponent_stat.attack/2)..(oponent_stat.attack*2/3))
					if oponent_special_attack == 3
						if oponent_mana >= 20 
							hit += oponent_stat.strength*2
							#combat_log += "Attack_turn2 hit.special #{hit.to_s}\n"
							oponent_mana -= 20
						end
						oponent_special_attack = 0
					else 
						oponent_special_attack += 1
					end
					if rand(100) <= (oponent_stat.agility - 18)*0.29 + 5.14
						hit = (hit*1.5).to_i 
						crit = true
					end
					if hit > current_user.robot.stat.armor/2
						hit -= current_user.robot.stat.armor/2
					end
					if rand(100) <= (current_user.robot.stat.defence/30).to_i
						hit = 0 
						block = true
					end
					m = Mob.find(params[:id])
					if block 
						combat_log += "#{m.name} missed\n"
						block = false
					else 
						if crit
							combat_log += "#{m.name} CRIT with un amount of: #{hit.to_s} damage\n"
							crit = false
						else 
							combat_log += "#{m.name} whitehited with un amount of #{hit.to_s} damage\n"
						end
					end
					current_user.robot.current_health -= hit
				end
			end
		end
		if 	current_user.robot.current_health <= 0
			current_user.robot.current_health = 1
		end
		current_user.robot.save
		if params[:oponent] == "Robot"
			r = Robot.find(params[:id])
			if oponent_health <= 0
				r.current_health = 1
			else 
				r.current_health = oponent_health
			end
			r.save
		end
		
		if current_user.robot.current_health > oponent_health
			if params[:oponent] == "Mob"
				Battle.create(:winner => current_user.username, :oponent_id => Mob.find(params[:id]).id, :oponent_type => params[:oponent],
				:robot_id => current_user.robot.id, :combat_log => combat_log)
				m = Mob.find(params[:id]) 
				m.lost = true
				m.save
				rewarding(current_user, current_user.robot.max_experience/7, current_user.robot.max_experience/7 - current_user.robot.level)
			else 
				Battle.create(:winner => current_user.username, :oponent_id => Robot.find(params[:id]).id, :oponent_type => params[:oponent], 
				:robot_id => current_user.robot.id, :combat_log => combat_log)
				rewarding(current_user, rand(current_user.robot.max_experience/7..current_user.robot.max_experience/7 + current_user.robot.level), 
				current_user.robot.max_experience/7 + current_user.robot.level)
			end
		else 
			if params[:oponent] == "Robot"
				Battle.create(:winner => Robot.find(params[:id]).name, :oponent_id => Robot.find(params[:id]).id, :oponent_type => params[:oponent], 
				:robot_id => current_user.robot.id, :combat_log => combat_log)
				rewarding(User.find(Robot.find(params[:id]).user_id), User.find(Robot.find(params[:id]).user_id).robot.max_experience + 
				(current_user.robot.level - User.find(Robot.find(params[:id]).user_id).robot.level), 
				User.find(Robot.find(params[:id]).user_id).robot.max_experience/7 + User.find(Robot.find(params[:id]).user_id).robot.level)
			else 
				Battle.create(:winner => Mob.find(params[:id]).name, :oponent_id => Mob.find(params[:id]).id, :oponent_type => params[:oponent], 
				:robot_id => current_user.robot.id, :combat_log => combat_log)	
			end
		end
			
		respond_to do |format|
			format.js
		end
	end


	def rewarding(winner, gold, experience)		
		winner.resource.gold += gold
		winner.resource.save
		message_con = "Congratulations! You have won the battle. Your rewards are: Gold: #{gold}"
		if rand(1..4) == 3 
			winner.resource.electricity += rand(10..50)
			message_con += ", Electricity: #{winner.resource.electricity}"
			winner.resource.oil += rand(10..50)
			message_con += ", Oil: winner.resource.oil"
		end
		message_con += ", Experience: #{experience}. Good Luck!"
		winner.resource.save
		m = Message.create(:from_user => "Service", :title => "Rewarding", :published_at => Time.now(),:unread => true ,:to_user => winner.username, :content => message_con)
		check_for_level(experience, winner)

	end

	def battlefield_list
		@users = User.all

	end

	def check_for_level(experience, winner)
		if (winner.robot.current_experience + experience) > winner.robot.max_experience
			gap = (winner.robot.current_experience + experience) - winner.robot.max_experience
			winner.robot.max_experience += 50	
			winner.robot.current_experience = gap
	    
		    m1 = Mob.where(:robot_id => winner.robot.id, :name => "Roshan").last
		    m1.level += current_user.robot.level
		    m1.talent_points += (winner.robot.unused_talent_points + winner.robot.used_talent_points) - 2*winner.robot.level
		    m1.picture = (m1.picture.to_i + 6).to_s
		    m1.lost = false
		    inc_mob_stats(m1)
		    m1.save

		    m2 = Mob.where(:robot_id => winner.robot.id, :name => "Balanar").last
		    m2.level = current_user.robot.level
		    m2.talent_points += (winner.robot.unused_talent_points + winner.robot.used_talent_points) - 2*winner.robot.level
		    m2.picture = (m2.picture.to_i + 6).to_s
		    m2.lost = false
			m2.save
		    inc_mob_stats(m2)
		    
		    m3 = Mob.where(:robot_id => winner.robot.id, :name => "Zefs").last
		    m3.level += current_user.robot.level
		    m3.talent_points += (winner.robot.unused_talent_points + winner.robot.used_talent_points)
		    m3.picture = (m3.picture.to_i + 6).to_s 
		    m3.lost = false
			m3.save
		    inc_mob_stats(m3)
		    
		    m4 = Mob.where(:robot_id => winner.robot.id, :name => "Riki").last
		    m4.level += current_user.robot.level
		    m4.talent_points += (winner.robot.unused_talent_points + winner.robot.used_talent_points)
		    m4.picture = (m4.picture.to_i + 6).to_s 
		    m4.lost = false
			m4.save
		    inc_mob_stats(m4)
		    
		    m5 = Mob.where(:robot_id => winner.robot.id, :name => "Axe").last
		    m5.level += current_user.robot.level
		    m5.talent_points += (winner.robot.unused_talent_points + winner.robot.used_talent_points) + (1.5*winner.robot.level).to_i
		    m5.picture = (m5.picture.to_i + 6).to_s 
		    m5.lost = false
			m5.save
		    inc_mob_stats(m5)
		    
		    m6 = Mob.where(:robot_id => winner.robot.id, :name => "Sniper").last
		    m6.level += current_user.robot.level
		    m6.talent_points += (winner.robot.unused_talent_points + winner.robot.used_talent_points) + 2*winner.robot.level
		    m6.picture = (m6.picture.to_i + 6).to_s
		    m6.lost = false
			m6.save
		    inc_mob_stats(m6)
			
			winner.robot.unused_talent_points += 10
			winner.robot.level += 1
			winner.robot.current_health = winner.robot.max_health
		else
			winner.robot.current_experience += experience
		end
		winner.robot.save
	end

	def inc_mob_stats(m)
		while m.talent_points > 0 do
		 	random_stat_value = 1 + rand(m.talent_points)
		 	m.talent_points -= 1
		 	random_stat_id = 1 + rand(7);
		 	case random_stat_id
				when 1 #attack
		 			m.stat.attack += 3;
				when 2 #strength
		 			m.stat.strength += 1;
				when 3 #agility
		 			m.stat.agility += 1;
				when 4 #intelligence
		 			m.stat.intelligence += 1;
				when 5 #stamina
		 			m.stat.stamina += 1;
				when 6 #defence
		 			m.stat.defence += 6;
				when 7 #armor
		 			m.stat.armor += 6;
				else
			  		puts "Error! Not a stat_id!";
			end
		end
		m.stat.save
		m.save
	end

	def set_stat
	  	stat_id = params[:id].to_i
	  	u = current_user
	  	case stat_id
			when 1 #attack
				u.robot.stat.attack += 3
			when 2 #strength
				u.robot.stat.strength += 1
			when 3 #agility
				u.robot.stat.agility += 1
			when 4 #intelligence
				u.robot.stat.intelligence += 1
			when 5 #stamina
				u.robot.stat.stamina += 1
				u.robot.max_health += 30
				u.robot.current_health += 30
			when 6 #defence
				u.robot.stat.defence += 6
			when 7 #armor
				u.robot.stat.armor += 6
			else
		  		puts "Error! Not such stat_id!"
		end
		u.robot.unused_talent_points -= 1
		u.robot.used_talent_points += 1
		u.robot.stat.save
		u.robot.save

		respond_to do |format|
			format.js
		end
	end

	def search
		if params[:name]  
			@data=params[:name]
 			@users = User.where("username like ?","%#{@data}%" )
 		
 		end
 	end
	
	def friendlist 
  		if not current_user.friends.find_by_friend_id(params[:id])
        	Friend.create(:user_id => current_user.id, :friend_id => params[:id])
  		else  
        	current_user.friends.find_by_friend_id(params[:id]).delete
      	end
      	@user = User.find(params[:id])
      	
      	respond_to do |format|
        	format.js
      	end
  	end

	def change_picture
		@picture = Picture.new
	end

	def fight
		@fight_mob = Mob.find_all_by_robot_id(current_user.robot.id)
	end 
end
