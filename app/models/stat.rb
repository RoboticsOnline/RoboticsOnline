class Stat < ActiveRecord::Base
  # Setup accessible (or protected) attributes for your model
  attr_accessible :strenght, :agility, :inteligence,
		:stamina, :defence, :armor, :attack
  # attr_accessible :title, :body

  belongs_to :statable, :polymorphic => true
end
