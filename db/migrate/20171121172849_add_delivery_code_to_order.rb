class AddDeliveryCodeToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :delivery_code, :string
  end
end
