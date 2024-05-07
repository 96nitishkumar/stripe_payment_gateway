FactoryBot.define do
  factory :chat_block_chat, class: 'ChatBlock::Chat' do
    name { "MyString" }
    chat_type { 1 }
  end
end
