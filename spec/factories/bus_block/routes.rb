FactoryBot.define do
  factory :bus_block_route, class: 'BusBlock::Route' do
    name { "MyString" }
    bus { nil }
  end
end
