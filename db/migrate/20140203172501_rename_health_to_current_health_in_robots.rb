class RenameHealthToCurrentHealthInRobots < ActiveRecord::Migration
  def change
	rename_column :robots, :health, :max_health
  end
end
