class CreateSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :subscriptions do |t|
      t.references :store, foreign_key: true
      t.integer :amount
      t.string :ref
      t.references :order_status, foreign_key: true
      t.string :description

      t.timestamps
    end
  end
end
