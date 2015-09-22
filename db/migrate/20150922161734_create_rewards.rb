class CreateRewards < ActiveRecord::Migration
  def change
    create_table :rewards do |t|
      t.text :description
      t.integer :amount
      t.references :campaign, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
