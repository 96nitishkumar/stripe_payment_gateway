class BookingSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id ,:from_date,:to_date,:room_id ,:booking_days,:total_price,:status, :user, :room ,:one_transaction

  # attributes :properties do |object|
  #   object.room
  # end

  # attributes :user do |object| 
  #   object.user
  # end
end
