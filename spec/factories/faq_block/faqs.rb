FactoryBot.define do
  factory :faq, class: 'FaqBlock::Faq' do
    title { "MyString" }
    description { "MyString" }
    category { "MyString" }
  end
end
