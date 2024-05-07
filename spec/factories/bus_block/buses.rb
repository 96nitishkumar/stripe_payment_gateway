FactoryBot.define do
  factory :bus_block_bus, class: 'BusBlock::Bus' do
    name { "MyString" }
    seats { 1 }
    from_location { "MyString" }
    to_location { "MyString" }
  end
end
