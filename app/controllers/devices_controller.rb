class DevicesController < ApplicationController
	before_action :authentication
	before_action :set_device, except: [:index,:create]

	def create
		device = @current_user.devices.build(device_params)
		if device.save
			render json: {data:  DeviceSerializer.new(device).serializable_hash, message: "device created"}
		else
			render json: {data:device.errors.full_messages, message: "device creatation fails"}, status: :unprocessable_entity
		end
	end

	def index
		devices = @current_user.devices
		render json: {data:  DeviceSerializer.new(devices).serializable_hash, message: "All device Details"}
	end 

	def show
		render json: {data:  DeviceSerializer.new(@device).serializable_hash, message: "device Details"}
	end

	def update
		if @device.update(device_params)
			render json: {data:  DeviceSerializer.new(@device).serializable_hash, message: "device updated"}
		else
			render json: {data: @device.errors.full_messages, message: "device not updated"}, status: :unprocessable_entity
		end
	end
	def destroy
		@device.destroy
		render json: {data: nil, message: "device deleted"}
	end

	def device_params
		params.require(:device).permit(:device_token)
	end

	def set_device
		@device = @current_user.devices.find(params[:id])
	end
end
