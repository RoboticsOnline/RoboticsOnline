class Friend < ActiveRecord::Base
  # Setup accessible (or protected) attributes for your model
  attr_accessible :user_id, :friend_id
  # attr_accessible :title, :body
  belongs_to :user

end
