class AddCollectorIdToPermutation < ActiveRecord::Migration
  def change
    add_column :permutations, :collector_id, :integer
  end
end
