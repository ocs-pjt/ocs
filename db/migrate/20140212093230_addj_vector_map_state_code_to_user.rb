class AddjVectorMapStateCodeToUser < ActiveRecord::Migration
  def change
    add_column :users, :jvectormap_state_code, :string
  end
end
