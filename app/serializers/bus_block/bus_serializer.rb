module BusBlock
  class BusSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id,:name,:from_location,:to_location,:is_ac,:sitting_seats,:sleeper_seats,:available

    attributes :available_seats do |object, params|
      day = params[:day] || Date.today
      city_1 = params[:city_1]
      city_2 = params[:city_2]
      buses = BookingBlock::BusBooking.where(bus_id:object.id)
      stop_1_position = BusBlock::Route.find_by(bus_id:object.id,name: city_1)&.position
      stop_2_position = BusBlock::Route.find_by(bus_id:object.id,name: city_2)&.position

      # position_1 = BusBlock::Route.where(bus_id:object.id).pluck(:position)
      seat_ids = buses.where('to_location >?',stop_1_position).pluck(:seat_id)

      bus_seats = BusBlock::Seat.find(seat_ids)
      available_seats = object.seats - bus_seats
      available_normal_seats_count = available_seats.count { |seat| seat.seat_type == "Normal" }
      available_sleeper_seats_count = available_seats.count { |seat| seat.seat_type != "Normal" }
      
      {
        seats: BusBlock::SeatSerializer.new(available_seats).serializable_hash,
        total_seats: object.seats.count,
        available_seats_count: available_seats.count,
        available_normal_seats_count: available_normal_seats_count,
        available_sleeper_seats_count: available_sleeper_seats_count,
        total_bookings: object.seats.count - available_seats.count
      }
    end
  end
end
