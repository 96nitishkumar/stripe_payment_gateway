class ChatBlock::Message < ApplicationRecord
belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"
  belongs_to :chat,class_name: "ChatBlock::Chat"
   has_many_attached :attachments, dependent: :destroy
end
