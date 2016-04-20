class CreateMenteeProfiles < ActiveRecord::Migration
  def change
    create_table :mentee_profiles do |t|
      t.integer :user_id
      t.integer :capacity
      t.boolean :is_available
      t.text :mentor_criteria

      t.timestamps null: false
    end
  end
end
