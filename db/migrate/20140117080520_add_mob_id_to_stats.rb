class AddMobIdToStats < ActiveRecord::Migration
  def change
    add_column :stats, :mob_id, :integer
  end
end
