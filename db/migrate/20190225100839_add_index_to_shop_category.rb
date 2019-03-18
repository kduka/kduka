class AddIndexToShopCategory < ActiveRecord::Migration[5.0]
  add_index :shop_categories, :shop_category, unique: {case_sensitive: false}
end
