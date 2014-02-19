class ChangeTheRalationOfStatsMobsAndRobots < ActiveRecord::Migration
  def change
	remove_column :stats, :robot_id
	remove_column :stats, :mob_id
	add_column :stats, :statable_id, :integer
	add_column :stats, :statable_type, :string
	
  end
end
