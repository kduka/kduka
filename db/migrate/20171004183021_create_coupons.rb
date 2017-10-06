class CreateCoupons < ActiveRecord::Migration[5.0]
  def change
    create_table :coupons do |t|
      t.references :store, foreign_key: true
      t.string :code
      t.integer :number_of_use
      t.integer :percentage
      t.date :expiry

      t.timestamps
    end
  end
end
