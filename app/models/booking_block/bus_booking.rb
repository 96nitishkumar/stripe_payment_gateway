module BookingBlock
  class BusBooking < ApplicationRecord
    self.table_name = :booking_block_bus_bookings
    belongs_to :user
    belongs_to :bus,class_name: "BusBlock::Bus"
    before_validation :check_dates
    enum status:["Booked","Cancled"]


    def self.ransackable_attributes(auth_object = nil)
      ["bus_id", "created_at", "day", "id", "id_value", "seat_number", "updated_at", "user_id"]
    end
    before_validation :check_availability

    def check_availability
      day = self.day || Date.today
      buses = BookingBlock::BusBooking.where(bus_id:self.bus_id)
      if buses.where('seat_id = ? AND from_location < ? AND to_location > ?', self.seat_id, to_location, from_location).present?# && buses.pluck(:seat_id).include?(self.seat_id)
        errors.add(:base, "In #{self.day} these date this seat '#{self.seat_id}' is not available")
        throw(:abort)
      end
    end

    def check_dates
      if day < Date.today
        errors.add(:base, "you need to give proper dates")
        # throw(:abort)
      end
    end
  end
end