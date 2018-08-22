class CreateSubscriptionRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :subscription_records do |t|
      t.references :store, foreign_key: true
      t.date :start
      t.date :expire
      t.references :subscription, foreign_key: true
      t.string :description

      t.timestamps
    end
  end
end
