class CreateDirectBookings < ActiveRecord::Migration
  def change
    create_table :direct_bookings do |t|
      t.references :driver_post, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :status

      t.timestamps null: false
    end
  end
end
