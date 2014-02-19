class CreateRobots < ActiveRecord::Migration
  def change
    create_table :robots do |t|
		## Database authenticatable
		t.integer :level, :default => 1
		t.integer :experience, :default => 1
		t.integer :max_experience, :default => 200
		t.time :time_travel, :default => 0
		t.integer :user_id

    end
  end
end
