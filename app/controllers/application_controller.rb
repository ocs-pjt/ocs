class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  #skip_before_action :verify_authenticity_token, if: :json_request?

  #before_action :authenticate_user_from_token!
  #before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end

  protected

    def json_request?
      request.format.json?
    end
 
  private

    # GIST : https://gist.github.com/josevalim/fb706b1e933ef01e4fb6#file-2_safe_token_authentication-rb
    def authenticate_user_from_token!
      email = params[:email].presence
      user = email && User.find_by(email: email)

      # Notice how we use Devise.secure_compare to compare the token
      # in the database with the token given in the params, mitigating
      # timing attacks.

      if user && Devise.secure_compare(user.authentication_token, params[:authentication_key].strip)
        sign_in user, store: false
      end
    end

end
