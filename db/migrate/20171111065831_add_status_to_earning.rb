class AddStatusToEarning < ActiveRecord::Migration[5.0]
  def change
    add_reference :earnings, :transaction_status, foreign_key: true
  end
end
