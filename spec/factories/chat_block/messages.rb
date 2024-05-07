FactoryBot.define do
  factory :chat_block_message, class: 'ChatBlock::Message' do
    message { "MyString" }
    user { nil }
    chat { nil }
    is_mark_read { false }
    message_type { 1 }
  end
end
