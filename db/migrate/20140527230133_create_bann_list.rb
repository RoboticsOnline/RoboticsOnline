class CreateBannList < ActiveRecord::Migration
  def change
    create_table :bann_lists do |t|
    	t.integer :user_id
    	
    	t.timestamp
    end
  end
end
