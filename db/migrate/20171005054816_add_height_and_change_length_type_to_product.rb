class AddHeightAndChangeLengthTypeToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :height, :integer
    change_column :products, :length, :integer
  end
end
