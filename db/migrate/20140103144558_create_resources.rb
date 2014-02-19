class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
		## Database authenticatable
		t.integer :gold, :default => 200
		t.integer :energy, :default => 600
		t.integer :oil, :default => 150
		t.integer :cristals, :integer => 2
		t.integer :user_id

    end
  end
end
