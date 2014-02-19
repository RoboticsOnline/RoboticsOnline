class ChangeParamNamesInRobotsAndMobs < ActiveRecord::Migration
  def change
	rename_column :robots, :experience, :current_experience
	rename_column :robots, :talent_points, :used_talent_points
	remove_column :robots, :time_travel
	rename_column :resources, :energy, :electricity
  end
end
