class AddCoordinateToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :del_location, :string
    add_column :orders, :del_lat, :string
    add_column :orders, :del_long, :string
  end
end
