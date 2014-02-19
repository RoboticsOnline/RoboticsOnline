class UserController < ApplicationController
  	def index
  		@battles = Battle.find_all_by_robot_id(current_user.robot.id) + Battle.find_all_by_oponent_id(current_user.robot.id)
 	end

 	def show 
 		@user = User.find_by_username(params[:username])
  		@battles = Battle.find_all_by_robot_id(@user.robot.id) + Battle.find_all_by_oponent_id(@user.robot.id)
 	end

	def battlefield
		#tuk shte ima 2 snimki 1 vs 2 kato v tetradkata 
		#kato ako nqma nishto shte ima kartinka s "?" i pri klik shte te prehvarlq vav fight
		if params[:id].nil?
			if params[:username].nil?
				
			else
				@user = User.find_by_username(params[:username])
			end
		else 
			@mob = Mob.find(params[:id])
		end
		
	end

	def main_battle 
		if params[:oponent] == "Mob"
			oponent_stat = Mob.find(params[:id]).stat	
			oponent_health = (oponent_stat.stamina - 33) * 30 + 1000	
		else 
			oponent_stat = Robot.find(params[:id]).stat
			oponent_health = Robot.find(params[:id]).current_health
		end
		combat_log = "asdasd asd asd asd asd asd asda sd \n asd asd \n fdsffds"
############ Main Battle
# trqbva da vada ot 30-50 electricity v zavisimost ot protivnika
# i trqbva da maham oil pri white hits
# combat log-aa
		oponent_special_attack = 1
		current_user_special_attack = 1
		#while current_user.robot.current_health > 0 && oponent_health > 0 do
			#sadasd
		#end

#########
		if current_user.robot.current_health > oponent_health
			if params[:oponent] == "Mob"
				Battle.create(:winner => current_user.username, :oponent_id => Mob.find(params[:id]).id, :oponent_type => params[:oponent], :robot_id => current_user.robot.id, :combat_log => combat_log)
				m = Mob.find(params[:id]) 
				m.lost = true
				m.save
			else 
				Battle.create(:winner => current_user.username, :oponent_id => Robot.find(params[:id]).id, :oponent_type => params[:oponent], :robot_id => current_user.robot.id, :combat_log => combat_log)
			end
			rewarding(current_user, 50, 50)
		else 
			if params[:oponent] == "Robot"
				Battle.create(:winner => Robot.find(params[:id]).name, :oponent_id => Robot.find(params[:id]).id, :oponent_type => params[:oponent], :robot_id => current_user.robot.id, :combat_log => combat_log)
				rewarding(User.find(Robot.find(params[:id]).user_id), 50, 50)	
			else 
				Battle.create(:winner => Mob.find(params[:id]).name, :oponent_id => Mob.find(params[:id]).id, :oponent_type => params[:oponent], :robot_id => current_user.robot.id, :combat_log => combat_log)	
			end
		end
			
		respond_to do |format|
			format.js
		end
	end

	def rewarding(winner, gold, experience)
		winner.resource.gold += gold
		winner.resource.save
		check_for_level(experience, winner)
		check_for_bonus(winner)

	end

	def battlefield_list
		#tuk shte ima spisak na vsichki hora podredeni sprqmo negoviq lvl koito toi moje da bie (ne se biqt)
		@users = User.all

	end

	def check_for_bonus(winner)
		if rand(1..4) == 3 
			winner.resource.electricity += rand(10..50)
			winner.resource.oil += rand(10..50)
		end
		winner.resource.save
	end

	def check_for_level(experience, winner)
		if (winner.robot.current_experience + experience) > winner.robot.max_experience
			gap = (winner.robot.current_experience + experience) - winner.robot.max_experience
			winner.robot.max_experience += 50	
			winner.robot.current_experience = gap
	    
		    m1 = Mob.where(:robot_id => winner.robot.id, :name => "Roshan").last
		    m1.level += 1
		    m1.talent_points += (winner.robot.unused_talent_points + winner.robot.used_talent_points) - 2*winner.robot.level
		    m1.picture = (m1.picture.to_i + 6).to_s
		    m1.lost = false
		    inc_mob_stats(m1)
		    m1.save

		    m2 = Mob.where(:robot_id => winner.robot.id, :name => "Balanar").last
		    m2.level += 1
		    m2.talent_points += (winner.robot.unused_talent_points + winner.robot.used_talent_points) - 2*winner.robot.level
		    m2.picture = (m2.picture.to_i + 6).to_s
		    m2.lost = false
			m2.save
		    inc_mob_stats(m2)
		    
		    m3 = Mob.where(:robot_id => winner.robot.id, :name => "Zefs").last
		    m3.level += 1
		    m3.talent_points += (winner.robot.unused_talent_points + winner.robot.used_talent_points)
		    m3.picture = (m3.picture.to_i + 6).to_s 
		    m3.lost = false
			m3.save
		    inc_mob_stats(m3)
		    
		    m4 = Mob.where(:robot_id => winner.robot.id, :name => "Riki").last
		    m4.level += 1
		    m4.talent_points += (winner.robot.unused_talent_points + winner.robot.used_talent_points)
		    m4.picture = (m4.picture.to_i + 6).to_s 
		    m4.lost = false
			m4.save
		    inc_mob_stats(m4)
		    
		    m5 = Mob.where(:robot_id => winner.robot.id, :name => "Axe").last
		    m5.level += 1
		    m5.talent_points += (winner.robot.unused_talent_points + winner.robot.used_talent_points) + (1.5*winner.robot.level).to_i
		    m5.picture = (m5.picture.to_i + 6).to_s 
		    m5.lost = false
			m5.save
		    inc_mob_stats(m5)
		    
		    m6 = Mob.where(:robot_id => winner.robot.id, :name => "Sniper").last
		    m6.level += 1
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

	def messages

	end

	def general_shop

	end

	def consumables_shop

	end

	def vipzone

	end

	def search

	end

	def fight

		@fight_mob = Mob.find_all_by_robot_id(current_user.robot.id)

	end 
end
