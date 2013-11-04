class CreateProgramsTagsSetsTable < ActiveRecord::Migration
  def self.up
    create_table :programs_tags_sets, :id => false do |t|
      t.references :program
      t.references :tags_set
    end

    add_index :programs_tags_sets, [:program_id, :tags_set_id]
    add_index :programs_tags_sets, :program_id
  end

  def self.down
    drop_table :programs_tags_sets
  end
   
end
