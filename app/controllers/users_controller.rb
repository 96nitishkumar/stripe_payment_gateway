class UsersController < ApplicationController
	before_action :authentication, except: [:signup,:login,:home]
	before_action :set_user, except: [:index,:signup,:login]
	
	def index
		user = User.all 
		render json: {data: user,message:"User list"}
	end

	def signup
		user = User.create(user_params)
		if user.save
			render json: {data:UserSerializer.new(user).serializable_hash, message: "User created"}
		else
			render json: {data: user.errors.full_messages, message: "User creation fails"},status: :unprocessable_entity
		end
	end

	def login
		user = User.find_by(email:params[:email])
		if user&&user.authenticate(params[:password])
			user.update_attribute(:device_token,params[:device_token]) if params[:device_token].present?
			token = JwtToken.encode_data(user)
			render json:{data: UserSerializer.new(user).serializable_hash, token:token, message:"User login"}
		else
			render json:{data: nil, message: "Invalid creadentials"},status: :unprocessable_entity
		end
	end

	def update
		if @user.update(user_params)
			render json:{data: @user, message:"User details updated"}
		end
	end

	def home
    # Assuming current_user returns the logged-in user
    @comet_chat_user = {
      uid: @user.id.to_s, # Unique user ID
      name: @user.name # User's name
      # avatar: @current_user.avatar_url # URL to user's avatar image
    }
    # @comet_chat_auth_token = generate_auth_token(current_user)
  end

	def set_user
		@user = User.find(params[:id])
		rescue StandardError => e 
		render json: {data: nil, error: e.message, message: "ID not found"}
	end

	def user_params
		params.require(:user).permit(:name, :email, :password, :phone_number)
	end
end
