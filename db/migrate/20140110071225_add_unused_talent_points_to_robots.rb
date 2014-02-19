class AddUnusedTalentPointsToRobots < ActiveRecord::Migration
  def change
  	add_column :robots, :unused_talent_points, :integer, :default => 10
  end
end
