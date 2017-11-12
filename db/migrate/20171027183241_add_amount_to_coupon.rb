class AddAmountToCoupon < ActiveRecord::Migration[5.0]
  def change
    add_column :coupons, :amount, :integer
  end
end
