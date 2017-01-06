class AddIndexToPosts < ActiveRecord::Migration
  def change
    add_index :posts, :original_id
  end
end
