FactoryBot.define do
  factory :bus_block_seat, class: 'BusBlock::Seat' do
    bus { nil }
    seat_type { 1 }
  end
end
