class AddFieldToItransaction < ActiveRecord::Migration[5.0]
  def change
    add_column :itransactions, :balance_as_of_now, :string
  end
end
