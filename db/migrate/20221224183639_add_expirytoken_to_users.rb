class AddExpirytokenToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :email_token_expires_at, :datetime, default: Time.now
    add_column :users, :contact_token_expires_at, :datetime, default: Time.now
  end
end
