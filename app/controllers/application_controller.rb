class ApplicationController < ActionController::API
	before_action :authenticate_user

	def authenticate_user
  	token = request.headers['Authorization']
  	@current_user = User.find_by(token: token)

  	unless @current_user
    	render json: { error: 'Unauthorized access' }, status: :unauthorized
  	end
  end
end
