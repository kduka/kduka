class AddLifeTimeEarningsToStoreAmount < ActiveRecord::Migration[5.0]
  def change
    add_column :store_amounts, :lifetime_earnings, :integer, :default => 0
  end
end
