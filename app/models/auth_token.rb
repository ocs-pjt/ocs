class AuthToken < ActiveRecord::Base
  mount_uploader :token, AuthTokenUploader
end
