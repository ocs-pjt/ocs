class CreateCollectorVersions < ActiveRecord::Migration
  def change
    create_table :collector_versions do |t|
      t.string :version
      t.integer :collector_id
      t.string :file

      t.timestamps
    end

    add_index "collector_versions", ["collector_id", "version"], unique: true
  end
end
