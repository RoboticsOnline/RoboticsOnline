class Picture < ActiveRecord::Base
	belongs_to :user
	attr_accessible :avatar

  	has_attached_file :avatar, :styles => {:medium => "", :thumb => "100x100>"}, 
  			:default_url => "/assets/:style/missing.png",
  			:convert_options => { :medium => "-resize 261x196^ -gravity Center -crop 261x196+0+0 +repage" }
  	validates_attachment_presence :avatar
  	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end