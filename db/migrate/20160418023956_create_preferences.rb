class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.integer :user_id
      t.text :description
      t.string :role

      t.timestamps null: false
    end
  end
end
