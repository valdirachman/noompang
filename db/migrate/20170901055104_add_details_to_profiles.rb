class AddDetailsToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :hobby, :text
    add_column :profiles, :age, :integer
    add_column :profiles, :gender, :boolean
    add_column :profiles, :university, :string
    add_column :profiles, :major, :string
    add_column :profiles, :about, :text
  end
end
