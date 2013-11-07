class CreatePermutation < ActiveRecord::Migration
  def change
    create_table :permutations do |t|
      t.text :data
      t.string :function
      t.integer :use_case_id

      t.timestamps
    end
  end
end
