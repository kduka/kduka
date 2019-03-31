class AddSubscriptionsToInvoice < ActiveRecord::Migration[5.0]
  def change
    add_reference :invoices, :subscription, foreign_key: true
  end
end
