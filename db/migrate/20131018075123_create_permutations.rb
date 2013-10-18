class CreatePermutations < ActiveRecord::Migration
  def change
    create_table :permutations do |t|
      t.text :permutation

      t.timestamps
    end
  end
end
