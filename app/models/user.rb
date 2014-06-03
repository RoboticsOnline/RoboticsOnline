class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  after_create :create_robot_for_user, :create_resource_for_user, :set_guild

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :password, :password_confirmation,
  :email, :rules_confirmation, :remember_me
  # attr_accessible :title, :body

  has_one :robot
  has_one :resource
  has_many :messages
  has_one :admin
  has_many :pictures
  has_many :friends
  belongs_to :guild
  
    def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
        user = User.where(:provider => auth.provider, :uid => auth.uid).first
        if user
            return user
        else
            registered_user = User.where(:email => auth.info.email).first
            if registered_user
                return registered_user
            else
                user = User.create(username:auth.extra.raw_info.name,
                        provider:auth.provider,
                                uid:auth.uid,
                                email:auth.info.email,
                                password:Devise.friendly_token[0,20]
                        )
                    auth.info.image
            end    
        end
    end
  
    def set_guild
        placed = false
        while !placed
            g_id = rand(3..Guild.all.count)
            if Guild.all.find(g_id)
              self.guild_id = g_id
              self.save
              placed = true
            end
        end       
    end

    def create_robot_for_user
        self.robot = Robot.create(:name => username)
    end
    def create_resource_for_user
        self.resource = Resource.create
    end
end
