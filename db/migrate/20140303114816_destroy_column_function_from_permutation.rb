class DestroyColumnFunctionFromPermutation < ActiveRecord::Migration
  def up
    remove_column :permutations, :function
  end
end
