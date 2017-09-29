class AddDetailedLocationToStore < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :detailed_location, :string
  end
end
