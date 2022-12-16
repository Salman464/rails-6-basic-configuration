class AddVerifyemailphoneToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :email_verified, :boolean
    add_column :users, :number_verified, :boolean
    add_column :users, :verification_token, :integer
  end
end
