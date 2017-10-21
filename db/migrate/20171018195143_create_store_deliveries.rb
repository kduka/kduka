class CreateStoreDeliveries < ActiveRecord::Migration[5.0]
  def change
    create_table :store_deliveries do |t|
      t.references :store, foreign_key: true
      t.string :delivery_areas
      t.integer :price

      t.timestamps
    end
  end
end
