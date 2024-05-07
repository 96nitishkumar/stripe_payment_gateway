class RoomSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :price, :location, :max_days, :status, :latitude, :longitude,:user
end
