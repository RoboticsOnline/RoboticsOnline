class CreateGuild < ActiveRecord::Migration
  def change
    create_table :guilds do |t|
    	t.integer :user_id
    	t.string :name

    	t.timestamp
    end
  end
end
