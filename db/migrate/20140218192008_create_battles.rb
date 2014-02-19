class CreateBattles < ActiveRecord::Migration
  def change
    create_table :battles do |t|
		## Database authenticatable
		t.string :winner
		t.integer :oponent_id
		t.string :oponent_type
    end
  end
end
