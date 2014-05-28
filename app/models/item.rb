class Item < ActiveRecord::Base 
  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :price
  # attr_accessible :title, :body

  has_one :stat, :as => :statable
end