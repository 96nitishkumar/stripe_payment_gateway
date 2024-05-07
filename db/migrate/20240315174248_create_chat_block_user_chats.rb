class CreateChatBlockUserChats < ActiveRecord::Migration[7.1]
  def change
    create_table :chat_block_user_chats do |t|
      t.references :user, null: false, foreign_key: true
      t.references :chat, foreign_key: { to_table: :chat_block_chats }

      t.timestamps
    end
  end
end
