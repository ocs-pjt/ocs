class CreateTraces < ActiveRecord::Migration
  def change
    create_table :traces do |t|
      t.text :data
      t.integer :use_case_id
      t.boolean :already_handled, default: false

      t.timestamps
    end
  end
end
