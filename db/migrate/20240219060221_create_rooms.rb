class CreateRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.integer :price
      t.string :location
      t.integer :max_days
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
