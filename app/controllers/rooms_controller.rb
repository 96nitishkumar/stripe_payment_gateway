class RoomsController < ApplicationController
	before_action :authentication
	before_action :set_room, except: [:index,:create,:properties, :user_properties,:check_avaliable_date,:check_available_rooms]

	def create
		room = @current_user.rooms.build(room_params)
		latitude_longitude = room.geocode
		if room.save
			render json:{data: RoomSerializer.new(room).serializable_hash, message: "Room created"}
		else
			render json:{data:room.errors.full_messages, message: "Room creatation fails"}, status: :unprocessable_entity
		end
	end

	def index
		rooms = Room.all
		render json:{data: RoomSerializer.new(rooms).serializable_hash, message: "All Room Details"}
	end 

	def show
		render json:{data: RoomSerializer.new(@room).serializable_hash, message: "Room Details"}
	end

	def update
		if @room.update(room_params)
			render json:{data: RoomSerializer.new(@room).serializable_hash, message: "Room updated"}
		else
			render json:{errors: @room.errors.full_messages, message: "Room not updated"}, status: :unprocessable_entity
		end
	end

	def destroy
		@room.destroy
		render json:{data: nil, message: "Room deleted"}
	end

	def check_avaliable_date
  	month = params[:month].to_i
  	year = params[:year].to_i
  	month == Date.today.month ? month = month : month > Date.today.month ? month = month : month = nil
  	return render json: {data: "give proper date"} if month == nil 
  	start_date = Date.new(year, month, 1)
  	end_date = Date.new(year, month, -1)
  	month_dates = (start_date..end_date).to_a
  	month_dates = (Date.today..Date.new(year, month, -1)).to_a if month == Date.today.month
  	rooms = Booking.joins(:room).where(bookings: { room_id: params[:room_id] })
  	if rooms.present?
  	rooms.each do |day| 
     		month_dates -= (day.from_date..day.to_date).to_a
    	end
    end
  	render json: { data: month_dates }
	end

	def check_available_rooms
  	from_date = Date.strptime(params[:from_date], "%d-%m-%y")
  	to_date = Date.strptime(params[:to_date], "%d-%m-%y")
  	return render json: {message: "give proper date"} if to_date < from_date || Date.today > from_date
  	days = (to_date - from_date).to_i
		bookings = Booking.where.not(status: "Reject")
  	booked_room_ids = bookings.where('from_date < ? AND to_date > ?', to_date, from_date).pluck(:room_id)
  	available_rooms = Room.where("status = ? AND max_days >= ?", 1, days).where.not(id: booked_room_ids)
  	available_rooms = available_rooms.near(params[:near_by], params[:kilometers] || 2) if params[:near_by]
  	render json: { data: available_rooms, message:"Available rooms"}
	end

	def user_properties
		rooms = @current_user.rooms
		render json: {data: rooms, message:"#{@current_user.name} Rooms"}
	end

	def properties
		rooms = Room.where.not(user_id: @current_user.id)
		render json: {data: rooms, message: "All properties details"}
	end

	def room_params
		params.require(:room).permit(:name,:price,:location, :max_days)
	end

	def set_room
		@room = @current_user.rooms.find(params[:id])
		rescue StandardError => e 
		render json: {data: nil, error: e.message, message: "Your not available to modifiy this room"}
	end
end
