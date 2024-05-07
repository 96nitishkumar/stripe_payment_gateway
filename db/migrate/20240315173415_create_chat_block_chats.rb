class CreateChatBlockChats < ActiveRecord::Migration[7.1]
  def change
    create_table :chat_block_chats do |t|
      t.string :name
      t.integer :chat_type

      t.timestamps
    end
  end
end
