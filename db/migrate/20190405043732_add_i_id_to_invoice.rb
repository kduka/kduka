class AddIIdToInvoice < ActiveRecord::Migration[5.0]
  def change
    add_column :invoices, :i_id, :string
    add_column :invoices, :invoice, :string
  end
end
