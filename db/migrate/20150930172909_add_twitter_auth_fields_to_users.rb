class AddTwitterAuthFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :uid, :string
    add_column :users, :provider, :string
    add_column :users, :twitter_consumer_token, :string
    add_column :users, :twitter_consumer_secret, :string
    add_column :users, :twitter_raw_data, :text

    add_index :users, [:uid, :provider]
  end
end
