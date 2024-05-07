module BookingBlock
  class BusBookingSerializer
    include FastJsonapi::ObjectSerializer
    attributes :day, :seat_number, :day, :status, :seat_id, :from_location, :to_location , :user,:bus
  
    # attributes :bus do |object|
    #   BusBlock::BusSerializer.new(object.bus,{ params:{ day:object.day } }).serializable_hash
    # end
  
    attributes :user do |object|
      UserSerializer.new(object.user).serializable_hash
    end
  end
end
