class CreateStatistics < ActiveRecord::Migration
  def change
    create_table :statistics do |t|
      t.integer :user_id
      t.hstore :stats

      t.timestamps
    end
  end
end
