class CreateCollectorVersions < ActiveRecord::Migration
  def change
    create_table :collector_versions do |t|
      t.string :version
      t.integer :collector_id

      t.timestamps
    end
  end
end
