class AddTypeToCoupon < ActiveRecord::Migration[5.0]
  def change
    add_column :coupons, :coupon_type, :string
  end
end
