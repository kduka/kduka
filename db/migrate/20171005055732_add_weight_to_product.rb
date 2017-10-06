class AddWeightToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :weight, :integer
  end
end
