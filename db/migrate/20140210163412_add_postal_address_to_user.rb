class AddPostalAddressToUser < ActiveRecord::Migration
  def change
    add_column :users, :postal_address, :string
  end
end
