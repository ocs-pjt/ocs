class CreateTagsTagsSetsTable < ActiveRecord::Migration
  def self.up
    create_table :tags_tags_sets, :id => false do |t|
      t.references :tag
      t.references :tags_set
    end

    add_index :tags_tags_sets, [:tag_id, :tags_set_id]
    add_index :tags_tags_sets, :tag_id
  end

  def self.down
    drop_table :tags_tags_sets
  end
end
