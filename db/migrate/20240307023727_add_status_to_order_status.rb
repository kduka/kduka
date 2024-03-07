class AddStatusToOrderStatus < ActiveRecord::Migration[5.0]
  def change
    add_column :order_statuses, :status, :integer, default: 0
  end
end
