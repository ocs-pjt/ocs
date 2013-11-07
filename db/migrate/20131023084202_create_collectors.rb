class CreateCollectors < ActiveRecord::Migration
  def change
    create_table :collectors do |t|
      t.string :name, unique: true
      t.string :file

      t.timestamps
    end
  end
end
