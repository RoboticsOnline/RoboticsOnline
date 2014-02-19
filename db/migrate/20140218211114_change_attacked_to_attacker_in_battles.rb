class ChangeAttackedToAttackerInBattles < ActiveRecord::Migration
  def change
	remove_column :battles, :attacked
	add_column :battles, :robot_id, :integer
  end
end
