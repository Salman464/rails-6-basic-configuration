# frozen_string_literal: true

class AddContactverifytokenToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :contact_verifcation_token, :integer
    rename_column :users, :verification_token, :email_verification_token
  end
end
