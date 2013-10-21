class AddNameToPermutation < ActiveRecord::Migration
  def change
    add_column :permutations, :name, :string
  end
end
