class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.string :name, unique: true
      t.text :description

      t.timestamps
    end
  end
end
