class CreateMentorProfiles < ActiveRecord::Migration
  def change
    create_table :mentor_profiles do |t|
      t.integer :user_id
      t.integer :capacity
      t.boolean :is_available
      t.text :mentee_criteria

      t.timestamps null: false
    end
  end
end
