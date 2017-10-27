class AddDiscountToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :discount, :integer, :default => 0
  end
end
