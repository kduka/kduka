class AddExploreImageToStore < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :explore_image, :string
  end
end
