class AddDeliveryChangesToStore < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :collection_point_status, :boolean
    rename_column :stores, :detailed_location, :collection_point
    rename_column :stores, :delivery_status, :auto_delivery_status
    rename_column :stores, :location, :auto_delivery_location
  end
end
