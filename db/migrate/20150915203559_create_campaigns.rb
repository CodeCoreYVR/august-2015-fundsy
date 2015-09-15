class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :title
      t.text :description
      t.integer :goal
      t.datetime :end_date
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
