class AddStatusToInvoice < ActiveRecord::Migration[5.0]
  def change
    add_reference :invoices, :order_status, foreign_key: true
  end
end
