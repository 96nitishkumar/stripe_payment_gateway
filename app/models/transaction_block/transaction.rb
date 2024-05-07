class TransactionBlock::Transaction < ApplicationRecord
  self.table_name  = 'transaction_block_transactions'
  belongs_to :user
  belongs_to :booking

  # enum transaction_status:["Pending","Success","Reject","Refund","Cancel"]
  
  def self.ransackable_attributes(auth_object = nil)
    ["accepted_by", "booking_id", "created_at", "id", "id_value", "paid_amount", "status", "total_amount", "transaction_status", "updated_at"]
  end
end
