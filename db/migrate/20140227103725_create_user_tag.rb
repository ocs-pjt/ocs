class CreateUserTag < ActiveRecord::Migration
  def self.up
    create_table :tags_users do |t|
      t.references :tag
      t.references :user
    end

    add_index :tags_users, [:user_id, :tag_id]
    add_index :tags_users, :user_id
  end

  def self.down
    drop_table :tags_users
  end
end
