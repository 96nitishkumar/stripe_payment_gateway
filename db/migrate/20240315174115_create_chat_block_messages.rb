class CreateChatBlockMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :chat_block_messages do |t|
      t.string :message
      t.integer :sender_id
      t.integer :receiver_id
      t.references :chat, foreign_key: true, foreign_key: { to_table: :chat_block_chats }
      t.boolean :is_mark_read
      t.integer :message_type

      t.timestamps
    end
  end
end
