class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.integer :amount
      t.references :store, foreign_key: true
      t.integer :balance
      t.string :type
      t.string :name
      t.string :ref
      t.string :account
      t.string :bankcode

      t.timestamps
    end
  end
end
