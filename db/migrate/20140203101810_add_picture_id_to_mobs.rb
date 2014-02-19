class AddPictureIdToMobs < ActiveRecord::Migration
  def change
    add_column :mobs, :picture_id, :integer
  end
end
