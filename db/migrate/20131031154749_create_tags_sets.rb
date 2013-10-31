class CreateTagsSets < ActiveRecord::Migration
  def change
    create_table :tags_sets do |t|

      t.timestamps
    end
  end
end
