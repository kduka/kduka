class AddDeliveriesToInvoice < ActiveRecord::Migration[5.0]
  def change
    add_column :invoices, :deliveries, :boolean
  end
end
