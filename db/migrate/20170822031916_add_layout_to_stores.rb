class AddLayoutToStores < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :layout, :string
  end
end
