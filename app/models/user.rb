class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :create_robot_for_user, :create_resource_for_user

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :password, :password_confirmation,
  :email, :rules_confirmation, :remember_me
  # attr_accessible :title, :body

  has_one :robot
  has_one :resource
  has_many :messages


  def create_robot_for_user
 	  self.robot = Robot.create(:name => username);
  end
  def create_resource_for_user
 	  self.resource = Resource.create
  end
end
