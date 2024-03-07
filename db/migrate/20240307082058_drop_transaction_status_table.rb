class DropTransactionStatusTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :earnings, :transaction_status_id
    remove_column :transactions, :transaction_status_id
    drop_table :transaction_statuses
  end
end
