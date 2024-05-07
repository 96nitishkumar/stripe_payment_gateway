FactoryBot.define do
  factory :booking_block_bus_booking, class: 'BookingBlock::BusBooking' do
    user { nil }
    bus { nil }
    day { "2024-03-27" }
  end
end
