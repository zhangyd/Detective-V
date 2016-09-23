class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable
  # attr_accessible :email, :password, :password_confirmation, :remember_me, :provider, :uid, :oauth_token, :oauth_expires_at

  # def self.create_with_omniauth(auth)
    # @user = User.create(provider: auth.provider, 
    #   uid: auth.uid, 
    #   name: auth.info.name,
    #   email: auth.info.email, 
    #   password: Devise.friendly_token[0,20])
    # where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    #   user.provider = auth["provider"]
    #   user.uid = auth["uid"]
    #   user.name = auth["info"]["name"]
    #   user.email = auth["info"]["email"]
    #   user.password = Devise.friendly_token[0,20]
    # end
    # create! do |user|
      # user.provider = auth["provider"]
      # user.uid = auth["uid"]
      # user.name = auth["info"]["name"]
      # user.email = auth["info"]["email"]
      # user.password = Devise.friendly_token[0,20]
    # end
  # end

  def self.from_omniauth(auth)
    if user = User.find_by_username(auth.info.name)
      user.provider = auth.provider
      user.uid = auth.uid
      user
    else
      where(auth.slice(:provider, :uid)).first_or_create do |user|
        user.provider = auth["provider"]
        user.uid = auth["uid"]
        user.name = auth["info"]["name"]
        user.email = auth["info"]["email"]
        user.password = Devise.friendly_token[0,20]
      end
    end
    # where(provider: auth["provider"]).first_or_create do |user|
      # user.provider = auth["provider"]
      # user.uid = auth["uid"]
      # user.name = auth["info"]["name"]
      # user.email = auth["info"]["email"]
      # user.password = Devise.friendly_token[0,20]
    # end
  end

end
