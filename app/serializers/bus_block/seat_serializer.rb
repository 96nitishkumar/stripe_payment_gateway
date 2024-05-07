module BusBlock
  class SeatSerializer
    include FastJsonapi::ObjectSerializer
    attributes :id,:seat_type,:seat_number,:status
  end
end
