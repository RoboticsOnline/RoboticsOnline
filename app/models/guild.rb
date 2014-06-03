class Guild < ActiveRecord::Base
  # Setup accessible (or protected) attributes for your model
  attr_accessible :user_id, :name
  # attr_accessible :title, :body
  has_many :users
  
end
