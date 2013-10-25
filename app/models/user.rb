class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

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
end
