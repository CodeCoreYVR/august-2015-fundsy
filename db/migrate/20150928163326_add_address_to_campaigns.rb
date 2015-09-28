class AddAddressToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :address, :string
  end
end
