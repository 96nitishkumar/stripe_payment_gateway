class AddColumnToRoom < ActiveRecord::Migration[7.1]
  def change
    add_column :rooms, :latitude, :float
    add_column :rooms, :longitude, :float
  end
end
