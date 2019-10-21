class AddAmountToItransaction < ActiveRecord::Migration[5.0]
  def change
    add_column :itransactions, :amount, :string
  end
end
