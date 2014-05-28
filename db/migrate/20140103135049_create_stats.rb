class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
		## Database authenticatable
		t.integer :strenght, :default => 23
		t.integer :agility, :default => 18
		t.integer :inteligence, :default => 20
		t.integer :stamina, :default => 33
		t.integer :defence, :default => 100
		t.integer :armor, :default => 100
		t.integer :attack, :default => 200
		t.integer :robot_id
    end
  end
end
