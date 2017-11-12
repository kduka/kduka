class AddAmountReceivedToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :amount_received, :integer
  end
end
