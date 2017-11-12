class AddMoreImagesToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :img2, :string
    add_column :products, :img3, :string
    add_column :products, :img4, :string
  end
end
