class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
		## Database authenticatable
		t.integer :from_id
		t.integer :to_id
		t.string :content
		t.boolean :unread, :default => true
		t.time :time_sent
		t.integer :user_id

    end
  end
end
