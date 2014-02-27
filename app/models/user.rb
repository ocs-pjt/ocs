class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :confirmable, :lockable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  before_save :ensure_authentication_token

  geocoded_by :postal_address do |obj,results|
    if geo = results.first
      obj.state = geo.state
      obj.country_code = geo.country_code
      obj.jvectormap_state_code = obj.jvm_state_code(obj.country_code, obj.state)
    end
  end
  reverse_geocoded_by :latitude, :longitude 
  after_validation :geocode, :reverse_geocode, if: -> { :postal_address_changed? }

  scope :filter_with, ->(filter_value) do 
    where('users.name ILIKE ? OR users.email ILIKE ?', "%#{filter_value}%", "%#{filter_value}%") 
  end

  has_many :tasks
  has_many :in_progress_tasks
  has_one :statistic
  has_many :use_cases

  has_many :tags_users
  has_many :default_tags, through: :tags_users

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

  # Create a user if not created to login with facebook
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

  # Create a user if not created to login with google
  def self.find_for_google_oauth(access_token, signed_in_resource=nil)
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

  # Get the jvectormap code map from the country and the state (set automatically by reverse_geocoded_by)
  def jvm_state_code(country_code, state)
    case country_code
    when "FR"
      CodeMatch::FRENCH_REGIONS[state]
    # TODO : mapping US states, Russia states etc ... 
    end
  end

  # Override devise
  def active_for_authentication?
    #remember to call the super
    #then put our own check to determine "active" state using 
    #our own "is_active" column
    super and self.is_active
  end

end
