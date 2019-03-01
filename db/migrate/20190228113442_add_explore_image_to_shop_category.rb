class AddExploreImageToShopCategory < ActiveRecord::Migration[5.0]
  def change
    add_column :shop_categories, :explore_image, :string
  end
end
