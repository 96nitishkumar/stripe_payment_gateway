class AddColumntoUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users,:stripe_connect_id,:string
  end
end
