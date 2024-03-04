# == Schema Information
#
# Table name: order_items
#
#  id          :integer          not null, primary key
#  quantity    :integer
#  total_price :decimal(12, 3)
#  unit_price  :decimal(12, 3)
#  variants    :text
#  created_at  :datetime
#  updated_at  :datetime
#  order_id    :integer
#  product_id  :integer
#
# Indexes
#
#  index_order_items_on_order_id    (order_id)
#  index_order_items_on_product_id  (product_id)
#
require 'test_helper'

class OrderItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
