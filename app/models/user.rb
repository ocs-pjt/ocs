class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :confirmable, :lockable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  before_save :ensure_authentication_token

  def self.authentication_token
    loop do
      token = Devise.friendly_token
      break token unless to_adapter.find_first({ authentication_token: token })
    end
  end

  def ensure_authentication_token
    reset_authentication_token if authentication_token.blank?
  end

  def reset_authentication_token
    self.authentication_token = self.class.authentication_token
  end

  # For login in with facebook
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    
    unless user
      user = User.new(name: auth.extra.raw_info.name,
                          provider: auth.provider,
                          uid: auth.uid,
                          email: auth.info.email,
                          password: Devise.friendly_token[0,20])
    
      user.skip_confirmation!
      user.save!
    end

    user
  end

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(email: data["email"]).first

    unless user
      user = User.new(name: data["name"],
           email: data["email"],
           password: Devise.friendly_token[0,20]
          )
      user.skip_confirmation!
      user.save!
    end

    user
  end

end
