class CreateProgramVersions < ActiveRecord::Migration
  def change
    create_table :program_versions do |t|
      t.string :version
      t.integer :program_id

      t.timestamps
    end
  end
end
