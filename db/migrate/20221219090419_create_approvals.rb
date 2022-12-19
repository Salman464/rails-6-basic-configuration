class CreateApprovals < ActiveRecord::Migration[6.0]
  def change
    create_table :approvals do |t|
      t.integer :status
      t.belongs_to :user
      t.timestamps
    end
  end
end
