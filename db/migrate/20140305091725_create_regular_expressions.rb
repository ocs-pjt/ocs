class CreateRegularExpressions < ActiveRecord::Migration
  def change
    create_table :regular_expressions do |t|
      t.text :data
      t.integer :use_case_id
      t.boolean :already_handled, default: false
      t.integer :additional_information_id

      t.timestamps
    end
  end
end
