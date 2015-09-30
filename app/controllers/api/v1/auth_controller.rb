class Api::V1::AuthController < ApplicationController
  before_action :authenticate, only: [:logout]
  def login
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      user.logged_in = true
      user.save
      render json: { token: user.token, message: "You have successfully logged in" }
    else
      render json: { errors: 'Invalid email/password combination' }
    end
  end

  def logout
    user = find_user
    user.generate_auth_token
    user.logged_in = false
    if user.save
      render json: "You have logged out successfully"
    else
      render json: { errors: "Error logging out"}
    end
  end
end