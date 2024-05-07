class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.integer :status
      t.date :from_date
      t.date :to_date
      t.integer :booking_days
      t.integer :total_price

      t.timestamps
    end
  end
end
