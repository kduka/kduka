class AddCouponStatusToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :coupon_status, :boolean, :default => false
  end
end
