##############FROM AUTH EXAMPLE#######################
class Api::V1::AuthController < ApplicationController
  ###########THIS IS FOR A "SESSION"###############
  skip_before_action :authorized, only: [:create, :show]

  def create
    # byebug
    user = User.find_by(username: user_login_params[:username])
    if user && user.authenticate(user_login_params[:password])
      token = encode_token({user_id: user.id})
      render json: { id: user.id, username: user.username, jwt: token }
    else
      render json: { message: "Invalid username or password" }, status: 401
    end
  end

  def show
    if logged_in?
      render json: {id: current_user.id, username: current_user.username}
    else
      render json: {error: 'no user could be found'}, status: 401
    end
  end

  def destroy
    current_user = nil
    auth_header = nil
  end

  private

  def user_login_params
    params.require(:user).permit(:username, :password)
  end

end
