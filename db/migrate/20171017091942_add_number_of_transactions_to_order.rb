class AddNumberOfTransactionsToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :number_of_transactions, :integer
  end
end
