class AddAlreadyHandledToPermutation < ActiveRecord::Migration
  def change
    add_column :permutations, :already_handled, :boolean, default: :false
  end
end
