class AddDiscountStatusToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :discount_status, :boolean, :default => false
  end
end
