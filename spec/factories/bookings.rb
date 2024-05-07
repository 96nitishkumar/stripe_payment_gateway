FactoryBot.define do
  factory :booking do
    user { nil }
    room { nil }
    status { false }
    total_price { 1 }
  end
end
