class CreateMob < ActiveRecord::Migration
  def change
    create_table :mobs do |t|
		t.integer :talent_point
		t.string  :name
		t.integer :level
		t.integer :robot_id
    end
  end
end
