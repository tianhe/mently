class AddRanksToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :mentor_rank, :integer
    add_column :matches, :mentee_rank, :integer
  end
end
