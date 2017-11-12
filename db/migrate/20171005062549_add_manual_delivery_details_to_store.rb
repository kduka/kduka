class AddManualDeliveryDetailsToStore < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :manual_delivery_status, :boolean
    add_column :stores, :manual_delivery_instructions, :text
  end
end
