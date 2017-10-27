class CreateStoreAmounts < ActiveRecord::Migration[5.0]
  def change
    create_table :store_amounts do |t|
      t.references :store, foreign_key: true
      t.integer :amount

      t.timestamps
    end
  end
end
