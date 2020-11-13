class ApplicationController < ActionController::API
	#controller callbacks
	# before_action :underscore_params!
 #  before_action :configure_permitted_parameters, if: :devise_controller?
	# before_action :authenticate_user

	# def authenticate_user!(options = {})
	# 	head :unauthorized unless signed_in?
	# end

	# def current_user
	# 	@current_user ||= super || User.find(@current_user_id)
	# end

	# def signed_in?
	# 	@current_user_id.present?
	# end

	# private

	# def configure_permitted_parameters
 #    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
 #  end

	# def authenticate_user
	# 	binding.pry
	# 	if request.headers['Authorization'].present?
	# 		authenticate_or_request_with_http_token do |token|
	# 			begin
	# 				jwt_payload = JWT.decode(token, Rails.application.secrets.secret_key_base).first

	# 				@current_user_id = jwt_payload['id']
	# 			rescue JWT::ExpiredSignature, JWT::VerficationError, JWT::DecodeError
	# 				head :unauthorized
	# 			end
	# 		end
	# 	else
	# 		render json: 'not permitted activity', status: :unprocessable_entity
	# 	end
	# end
end
