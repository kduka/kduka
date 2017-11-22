class AddActualToStoreAmount < ActiveRecord::Migration[5.0]
  def change
    add_column :store_amounts, :actual, :integer, :default => 0
  end
end
