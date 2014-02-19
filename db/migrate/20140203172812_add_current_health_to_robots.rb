class AddCurrentHealthToRobots < ActiveRecord::Migration
  def change
	add_column :robots, :current_health, :integer, :default => 1000
  end
end
