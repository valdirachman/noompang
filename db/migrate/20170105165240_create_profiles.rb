class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name
      t.text :description
      t.string :occupation
      t.string :occupation_place
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
