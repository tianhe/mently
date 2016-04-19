class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.references :mentor
      t.references :mentee
      t.integer    :status
      t.datetime   :start_date
      t.datetime   :end_date

      t.timestamps null: false            
    end

    add_foreign_key :matches, :users, column: :mentee_id
  end
end
