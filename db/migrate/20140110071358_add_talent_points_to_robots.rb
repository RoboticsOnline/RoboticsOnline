class AddTalentPointsToRobots < ActiveRecord::Migration
  def change
  	add_column :robots, :talent_points, :integer, :default => 0
  end
end
