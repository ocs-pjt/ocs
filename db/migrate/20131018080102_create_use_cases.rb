class CreateUseCases < ActiveRecord::Migration
  def change
    create_table :use_cases do |t|
      t.string :program

      t.timestamps
    end
  end
end
