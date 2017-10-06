class AddDimensionsToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :width, :integer
    add_column :products, :length, :decimal
  end
end
