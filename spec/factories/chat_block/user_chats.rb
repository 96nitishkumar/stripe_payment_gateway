FactoryBot.define do
  factory :chat_block_user_chat, class: 'ChatBlock::UserChat' do
    user { nil }
    chat { nil }
  end
end
