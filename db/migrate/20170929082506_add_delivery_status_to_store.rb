class AddDeliveryStatusToStore < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :delivery_status, :boolean
  end
end
