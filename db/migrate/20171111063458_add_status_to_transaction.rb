class AddStatusToTransaction < ActiveRecord::Migration[5.0]
  def change
    add_reference :transactions, :transaction_status, foreign_key: true
  end
end
