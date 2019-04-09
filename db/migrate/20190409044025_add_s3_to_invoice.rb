class AddS3ToInvoice < ActiveRecord::Migration[5.0]
  def change
    add_column :invoices, :url, :string
    add_column :invoices, :name, :string
  end
end
