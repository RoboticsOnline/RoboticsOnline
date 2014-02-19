class Battle < ActiveRecord::Base
  attr_accessible :winner, :robot_id, :oponent_type, :oponent_id, :combat_log
  # attr_accessible :title, :body

  belongs_to :oponent, :polymorphic => true

end
