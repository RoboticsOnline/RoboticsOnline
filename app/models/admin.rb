class Admin < ActiveRecord::Base
	attr_accessible :permission

	belongs_to :user
end