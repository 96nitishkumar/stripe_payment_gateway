class Device < ApplicationRecord
  # belongs_to :user

  # def self.ransackable_attributes(auth_object = nil)
  #   # ["created_at", "device_token", "id", "id_value", "updated_at", "user_id"]
  # end
end
# [user_booking.last.from_date, user_booking.last.to_date].include?(from_date)