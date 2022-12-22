# frozen_string_literal: true

class RenameConactVerficationTokenInUsers < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :contact_verifcation_token, :contact_verification_token
  end
end
