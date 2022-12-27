class AddJwtsecretToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :jwt_secret, :string
    add_column :users, :jwt_secret_expires_at, :datetime, default: Time.now
  end
end
