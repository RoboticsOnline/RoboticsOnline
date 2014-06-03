class Robot < ActiveRecord::Base
  attr_accessible :level, :experience, :max_experience, :name
  # attr_accessible :title, :body

  after_create :create_stat_for_robot, :create_mob_for_robot

  belongs_to :user
  has_one :stat, :as => :statable
  has_many :pictures, :as => :pictureable
  has_many :battles, :as => :oponent
  has_many :mobs

  def create_stat_for_robot
	 self.stat = Stat.create
  end

  def create_mob_for_robot
	  self.mobs << Mob.create(:name => "Roshan", :level => 1, :talent_points => 8, :picture => "1");
    self.mobs << Mob.create(:name => "Balanar", :level => 1, :talent_points => 9, :picture => "2");
    self.mobs << Mob.create(:name => "Zefs", :level => 1, :talent_points => 10, :picture => "3");
    self.mobs << Mob.create(:name => "Riki", :level => 1, :talent_points => 10, :picture => "4");
    self.mobs << Mob.create(:name => "Axe", :level => 1, :talent_points => 11, :picture => "5");
    self.mobs << Mob.create(:name => "Sniper", :level => 1, :talent_points => 12, :picture => "6");    
  end
end
