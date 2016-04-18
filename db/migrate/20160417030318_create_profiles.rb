class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string  :first_name
      t.string  :last_name
      t.integer :gender
      t.string  :linkedin_url
      t.string  :department
      t.string  :function
      t.string  :experience
      t.string  :location

      t.timestamps null: false
    end
  end
end
