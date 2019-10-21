class CreateInvoices < ActiveRecord::Migration[5.0]
  def change
    create_table :invoices do |t|
      t.date :from
      t.date :to
      t.string :uid
      t.references :store, foreign_key: true
      t.integer :amount
      t.date :issued
      t.date :due
      t.integer :tax
      t.integer :subtotal
      t.string :currency
      t.text :description

      t.timestamps
    end
  end
end
