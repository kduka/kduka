class AddShopCategoryToStores < ActiveRecord::Migration[5.0]
  def change
    add_reference :stores, :shop_category, foreign_key: true
  end
end
