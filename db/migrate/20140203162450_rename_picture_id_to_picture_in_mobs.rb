class RenamePictureIdToPictureInMobs < ActiveRecord::Migration
  def change
	rename_column :mobs, :picture_id, :picture
  end
end
