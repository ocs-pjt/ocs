class UsersController < ApplicationController
  before_action :authenticate_user!, except: :authentication_key # Normal devise authentication
  
  def index
    authorize! :index, @user, message: 'Not authorized as an administrator.'
    @users = User.paginate(page: params[:page], per_page: 30).filter_with(params['search_value'])

    render partial: 'users_list', locals: { users: @users } if request.xhr?
  end

  def show
    @user = User.find(params[:id])
  end
  
  def update
    authorize! :update, @user, message: 'Not authorized as an administrator.'
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to users_path, notice: "User updated."
    else
      redirect_to users_path, alert: "Unable to update user."
    end
  end
    
  def destroy
    authorize! :destroy, @user, message: 'Not authorized as an administrator.'
    user = User.find(params[:id])
    unless user == current_user
      user.destroy
      redirect_to users_path, notice: "User deleted."
    else
      redirect_to users_path, notice: "Can't delete yourself."
    end
  end

  def authentication_key
    if user = User.find_by(email: params[:email].to_s.strip.downcase)
      if user.valid_password?(params[:password].to_s.strip)
        msg = user.authentication_token
      else
        msg = "Invalid password"
      end
    else
      msg = "Invalid user"
    end

    render text: msg
  end

  private

    def user_params
      params.require(:user).permit(:locked_at, :is_active, :role_ids)
    end
end