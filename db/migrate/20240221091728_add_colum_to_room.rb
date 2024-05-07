class AddColumToRoom < ActiveRecord::Migration[7.1]
  def change
    add_column :rooms, :status, :integer
  end
end
