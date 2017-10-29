class CreateEarnings < ActiveRecord::Migration[5.0]
  def change
    create_table :earnings do |t|
      t.string :trans_id
      t.references :store, foreign_key: true
      t.integer :amount
      t.string :ref

      t.timestamps
    end
  end
end
