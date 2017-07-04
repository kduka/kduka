class AddSkuToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :sku, :string
  end
end
