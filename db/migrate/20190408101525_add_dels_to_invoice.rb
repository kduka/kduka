class AddDelsToInvoice < ActiveRecord::Migration[5.0]
  def change
    add_column :invoices, :firt_del, :boolean
    add_column :invoices, :second_del, :boolean
  end
end
