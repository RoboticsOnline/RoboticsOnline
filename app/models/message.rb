class Message < ActiveRecord::Base
	attr_accessible :from_user, :to_user, :title, :content, :published_at, :unread

  belongs_to :user
  validates_presence_of :to_user, :title, :content

  validate :must_have_an_existing_to_user

  	def must_have_an_existing_to_user
      u = User.find_by_username(to_user)
      errors.add(:to_error, ": The user does not exist") if u == nil
  	end

end
