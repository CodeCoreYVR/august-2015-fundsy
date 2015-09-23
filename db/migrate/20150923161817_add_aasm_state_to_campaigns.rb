class AddAasmStateToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :aasm_state, :string
  end
end
