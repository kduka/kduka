class AddStoreColorToStore < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :store_color, :string
  end
end
