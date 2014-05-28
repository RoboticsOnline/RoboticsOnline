class Resource < ActiveRecord::Base
  attr_accessible :gold, :energy, :oil, :cristals
  # attr_accessible :title, :body

  belongs_to :user
end