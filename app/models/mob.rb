class Mob < ActiveRecord::Base
  # Setup accessible (or protected) attributes for your model
  attr_accessible :talent_points, :name, :level, :picture
  # attr_accessible :title, :body
  after_create :create_stat_for_mob

  belongs_to :robot
  has_one :stat, :as => :statable
  has_many :battles, :as => :oponent

  def create_stat_for_mob
	self.stat = Stat.create
	self.talent_points = 10
		while self.talent_points > 0 do
			random_stat_value = 1 + rand(self.talent_points);
			self.talent_points = self.talent_points - random_stat_value;
			random_stat_id = 1 + rand(7);
			case random_stat_id
				when 1 #attack
					self.stat.attack = self.stat.attack + random_stat_value*3;
				when 2 #strength
					self.stat.strength = self.stat.strength + random_stat_value*1;
				when 3 #agility
					self.stat.agility = self.stat.agility + random_stat_value*1;
				when 4 #intelligence
					self.stat.intelligence = self.stat.intelligence + random_stat_value*1;
				when 5 #stamina
					self.stat.stamina = self.stat.stamina + random_stat_value*1;
				when 6 #defence
					self.stat.defence = self.stat.defence + random_stat_value*6;
				when 7 #armor
					self.stat.armor = self.stat.armor + random_stat_value*6;
				else
					puts "Error! Not a stat_id!";
			end
		end
	self.stat.save;
  end
end
