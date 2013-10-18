class AddColumnsToPermutation < ActiveRecord::Migration
  def change
    add_column :permutations, :user_id, :integer
    add_column :permutations, :use_case_id, :integer
  end
end
