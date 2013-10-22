class RemoveTokenFromAuthToken < ActiveRecord::Migration
  def change
    remove_column :auth_tokens, :token
  end
end
