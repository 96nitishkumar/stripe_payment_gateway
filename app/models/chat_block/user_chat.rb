class ChatBlock::UserChat < ApplicationRecord
  belongs_to :user
  belongs_to :chat,class_name: "ChatBlock::Chat"
end
