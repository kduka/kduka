class AddExploreToStores < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :explore, :boolean
  end
end
