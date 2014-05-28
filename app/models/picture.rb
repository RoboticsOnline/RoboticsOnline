class Picture < ActiveRecord::Base
	belongs_to :pictureable, :polymorphic => true
	attr_accessible :avatar

  	has_attached_file :avatar, :styles => {:medium => "380х540>", :thumb => "100x100>"}, :default_url => "/assets/:style/missing.png"
  	validates_attachment_presence :avatar
  	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end