class AddCapacityToPreferences < ActiveRecord::Migration
  def change
    add_column :preferences, :capacity, :integer
  end
end
