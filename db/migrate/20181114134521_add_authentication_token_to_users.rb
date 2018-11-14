# db/migrate/20181114134521_add_authentication_token_to_users.rb
class AddAuthenticationTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :auth_token, :string, default: ''
    add_index :users, :auth_token, unique: true
  end
end
