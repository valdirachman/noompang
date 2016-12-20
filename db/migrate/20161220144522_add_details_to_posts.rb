class AddDetailsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :from, :string
    add_column :posts, :destination, :string
    add_column :posts, :date, :date
    add_column :posts, :time, :time
  end
end
