class AddTokenToAuthToken < ActiveRecord::Migration
  def change
    add_column :auth_tokens, :token, :string
  end
end
