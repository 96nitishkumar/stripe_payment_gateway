class BookingsController < ApplicationController
	before_action :authentication
	before_action :set_booking, only: [:show, :destroy,:update,:cancel_booking]
	before_action :update_status, only: [:update_owner]

	def create
		booking = @current_user.bookings.build(booking_params)
		if booking.save
			payment = Payment.send_amount_to_connections(booking.total_price,booking.room.user)
			send_owner_push_notification(booking.room.user_id)
			render json: {data: BookingSerializer.new(booking).serializable_hash ,payment: payment, message:"Booking created"}
		else
			render json: {data: nil, error: booking.errors.full_messages, message: "Booking creation fails"}, status: :unprocessable_entity
		end
	end

	def index
  	bookings = @current_user.bookings
  	render json:{data: BookingSerializer.new(bookings).serializable_hash, message: "All bookings Details"}
  end 

	def show
		render json:{data: BookingSerializer.new(@booking).serializable_hash, message: "Booking Details"}
	end

	def update
		if @booking.update(booking_params)
			send_user_push_notification(params[:booking][:status], @booking.user_id)
			render json:{data: BookingSerializer.new(@booking).serializable_hash, message: "Booking updated"}
		else
			render json:{errors: @booking.errors.full_messages, message: "Booking not updated"}, status: :unprocessable_entity
		end
	end

	def update_owner
		if @booking.update(status:params[:booking][:status])
			send_user_push_notification(params[:booking][:status], @booking.user_id)
			render json:{data: BookingSerializer.new(@booking).serializable_hash, message: "Booking updated"}
		end
		rescue StandardError => e
			render json:{errors: @booking.errors.full_messages, message: "Booking not updated"}, status: :unprocessable_entity
	end

	def destroy
		@booking.destroy
		render json:{data: nil, message: "Booking deleted"}
	end

	def user_bookigs
		user_bookings = @current_user.bookings
		user_bookings = @current_user.bookings.where(status: params[:status]) if params[:status].present?
		render json:{data: BookingSerializer.new(user_bookings).serializable_hash , message: "User Bookings"}
	end

	def owner_bookings
  	bookings = Booking.joins(:room).where(rooms: { user_id: @current_user.id })
  	render json: { data:BookingSerializer.new(bookings).serializable_hash, message: "Owner Bookings" }
	end

	def owner_feature_bookings
  	bookings = Booking.joins(:room).where(rooms: { user_id: @current_user.id })
  	bookings = bookings.where("from_date > ? AND bookings.status = ?", Date.today, 1)
  	render json: { data:BookingSerializer.new(bookings).serializable_hash, message: "Owner feature bookings" }
	end

	def user_feature_bookings
		bookings = @current_user.bookings.where("from_date > ? AND status = ?", Date.today, 1)
		render json:{data: BookingSerializer.new(bookings).serializable_hash , message: "User feature  Bookings"} 
	end

	def cancel_booking
	 @booking.update(status:"Cancel")
	 message = "Your Booking canceld"
	 message =  "You not did any transactions, so you don't get any refund amount" if @booking.one_transaction.transaction_status != "Success"
	render json:{data: BookingSerializer.new(@booking).serializable_hash, message:message}
	end

	def booking_params
		params.require(:booking).permit(:from_date,:to_date,:room_id,:status)
	end

	def set_booking
		@booking = @current_user.bookings.find(params[:id])
		rescue StandardError => e 
		render json: {data: nil, error: e.message, message: "You have no room with this id '#{params[:id]}'"}
	end

	def update_status
		@booking = Booking.find(params[:id])
		@status = @current_user.rooms.find(@booking.room_id)
	rescue StandardError => e 
		render json: {data: nil, error: e.class, message: "Your not available to Accept or Reject"},status: :unprocessable_entity
	end

	def send_user_push_notification(status,user)
  	user = User.find_by(id:user)
  	device_id = user&.device_token
    if device_id.present?
      notification = Notification.new(user_id: user.id, title: "Your booking #{status}")
      notification.save
    end
  end
  def send_owner_push_notification(user)
  	user = User.find_by(id:user)
  	device_id = user&.device_token
 		if device_id.present?
  	  notification = Notification.new(user_id: user.id, title: "#{current_user.name} sent one booking request")
  	  notification.save
		end
	end
end
