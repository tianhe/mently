class AddTitleToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :title, :string
  end
end
