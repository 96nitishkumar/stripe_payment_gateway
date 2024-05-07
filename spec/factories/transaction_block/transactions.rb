FactoryBot.define do
  factory :transaction_block_transaction, class: 'TransactionBlock::Transaction' do
    total_amount { 1.5 }
    paid_amount { 1.5 }
    transaction_status { "MyString" }
    status { "MyString" }
    booking { nil }
    accepted_by { 1 }
  end
end
