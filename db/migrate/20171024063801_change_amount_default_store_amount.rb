class ChangeAmountDefaultStoreAmount < ActiveRecord::Migration[5.0]
  def change
    change_column :store_amounts, :amount, :integer, :default => 0
  end
end
