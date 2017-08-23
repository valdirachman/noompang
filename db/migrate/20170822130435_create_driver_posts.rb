class CreateDriverPosts < ActiveRecord::Migration
  def change
    create_table :driver_posts do |t|
      t.string :from
      t.string :destination
      t.date :date
      t.time :time
      t.string :note
      t.integer :price
      t.integer :quantity
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
