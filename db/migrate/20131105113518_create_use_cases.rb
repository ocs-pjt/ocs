class CreateUseCases < ActiveRecord::Migration
  def change
    create_table :use_cases do |t|
      t.string :key
      t.integer :user_id
      t.integer :collector_version_id
      t.integer :program_id
      t.integer :program_version_id

      t.timestamps
    end
  end
end
