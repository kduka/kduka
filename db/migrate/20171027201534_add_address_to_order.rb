class AddAddressToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :address, :string
  end
end
