class AddStatusToInvoiceAndSubscription < ActiveRecord::Migration[5.0]
  def change
    add_column :invoices, :status, :integer, default: 0
    add_column :subscriptions, :status, :integer, default: 0
  end
end
