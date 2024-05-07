module ChatBlock
	class Chat < ApplicationRecord
		has_many :messages
  	has_many :user_chats
  	has_many :users, through: :user_chats	
		enum chat_type: ["Direct", "Group"]
	end
end
