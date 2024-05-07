class ApplicationController < ActionController::Base
	skip_forgery_protection
	attr_accessor :current_user

	def authentication
		begin 
			token = JwtToken.decode_data(request.headers["token"])
			id = token[0]["id"]
			@current_user = User.find(id)
		rescue StandardError => e
		   return render json: {message: "token exp"}
		end
	end

	rescue_from ActiveRecord::RecordNotFound do |exception|
        render json: { warning: exception.message }, status: :not_found
    end
end
