class AddDeliveryToStore < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :location, :string
    add_column :stores, :lat, :string
    add_column :stores, :lng, :string
  end
end