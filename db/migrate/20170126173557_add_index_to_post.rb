class AddIndexToPost < ActiveRecord::Migration
  def change
    add_index :posts, :date
  end
end
