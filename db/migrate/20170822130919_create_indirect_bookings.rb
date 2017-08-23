class CreateIndirectBookings < ActiveRecord::Migration
  def change
    create_table :indirect_bookings do |t|
      t.references :driver_post, index: true, foreign_key: true
      t.references :post, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :status

      t.timestamps null: false
    end
  end
end
