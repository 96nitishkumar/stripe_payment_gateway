class AddColumnToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :device_token, :string
  end
end
