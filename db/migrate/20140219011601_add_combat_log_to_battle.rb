class AddCombatLogToBattle < ActiveRecord::Migration
  def change
	add_column :battles, :combat_log, :string
  end
end
