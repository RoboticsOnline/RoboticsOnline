class ChangeGuildAndUserTables < ActiveRecord::Migration
  def change
  	add_column :users, :guild_id, :integer
  	remove_column :guilds, :user_id
  end
end
