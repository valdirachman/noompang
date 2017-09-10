class AddProgressToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :progress, :integer
  end
end
