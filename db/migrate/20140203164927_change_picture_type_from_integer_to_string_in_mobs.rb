class ChangePictureTypeFromIntegerToStringInMobs < ActiveRecord::Migration
  def change
	change_column :mobs, :picture, :string
  end
end
