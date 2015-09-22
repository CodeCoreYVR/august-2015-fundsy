class AddPasswordResetTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_reset_token, :string
    add_column :users, :password_reset_expiry_date, :datetime

    add_index :users, :password_reset_token
  end
end
