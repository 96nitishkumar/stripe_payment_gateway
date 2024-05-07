class CreateTransactionBlockTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transaction_block_transactions do |t|
      t.float :total_amount,default: 0
      t.float :paid_amount,default: 0
      t.string :transaction_status
      t.references :user, null: false, foreign_key: true
      t.references :booking, null: false, foreign_key: true
      t.float :refund, default: 0

      t.timestamps
    end
  end
end
