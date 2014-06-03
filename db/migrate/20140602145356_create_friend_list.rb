class CreateFriendList < ActiveRecord::Migration
  def change
    create_table :friend_lists do |t|
    	t.integer :user_id
    	t.integer :friend_id

    	t.timestamp
    end
  end
end
