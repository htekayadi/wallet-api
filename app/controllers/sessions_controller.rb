class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: [:create]

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      user.reset_token!  # Generate a new session token
      render json: { token: user.token }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def destroy
    user = User.find_by(token: request.headers['Authorization'])

    if user
      user.reset_token!  # Invalidate the session token
      render json: { message: 'Logged out successfully' }, status: :ok
    else
      render json: { error: 'Invalid token' }, status: :unauthorized
    end
  end
end