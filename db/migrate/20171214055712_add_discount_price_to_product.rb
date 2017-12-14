class AddDiscountPriceToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :discount_price, :integer
  end
end
