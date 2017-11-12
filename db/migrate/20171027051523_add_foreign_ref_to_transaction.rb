class AddForeignRefToTransaction < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :foreign_ref, :string
  end
end
