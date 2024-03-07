class DropOrderStatusTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :invoices, :order_status_id
    remove_column :subscriptions, :order_status_id
    drop_table :order_statuses
  end
end
