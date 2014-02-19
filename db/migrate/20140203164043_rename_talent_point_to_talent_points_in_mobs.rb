class RenameTalentPointToTalentPointsInMobs < ActiveRecord::Migration
  def change
	rename_column :mobs, :talent_point, :talent_points
  end
end
