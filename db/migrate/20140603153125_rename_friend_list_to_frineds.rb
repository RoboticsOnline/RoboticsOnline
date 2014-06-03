class RenameFriendListToFrineds < ActiveRecord::Migration
  def change
  	rename_table :friend_lists, :friends
  end
end
