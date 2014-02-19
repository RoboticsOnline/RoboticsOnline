class AddPictureToUserAndLostToMobs < ActiveRecord::Migration
  def change
	add_column :users, :picture, :string, :default => "profile-img.png"
	add_column :mobs, :lost, :boolean, :default => false
  end
end
