# == Schema Information
#
# Table name: shop_categories
#
#  id            :integer          not null, primary key
#  shop_category :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_shop_categories_on_shop_category  (shop_category) UNIQUE
#
require 'test_helper'

class ShopCategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
