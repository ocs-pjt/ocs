class CreateUseCaseTag < ActiveRecord::Migration
  def self.up
    create_table :tags_use_cases, :id => false do |t|
      t.references :tag
      t.references :use_case
    end

    add_index :tags_use_cases, [:use_case_id, :tag_id]
    add_index :tags_use_cases, :use_case_id
  end

  def self.down
    drop_table :tags_use_cases
  end
end
