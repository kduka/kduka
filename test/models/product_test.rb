# == Schema Information
#
# Table name: products
#
#  id               :integer          not null, primary key
#  active           :boolean
#  additional_info  :string
#  description      :text
#  discount_price   :integer
#  discount_status  :boolean          default(FALSE)
#  height           :integer
#  image            :string
#  img1             :string
#  img2             :string
#  img3             :string
#  img4             :string
#  length           :integer
#  long_description :text
#  name             :string
#  number_sold      :integer
#  price            :decimal(12, 3)
#  quantity         :integer
#  sku              :string
#  viewed           :integer
#  weight           :integer
#  width            :integer
#  created_at       :datetime
#  updated_at       :datetime
#  category_id      :integer
#  store_id         :integer
#
# Indexes
#
#  index_products_on_category_id  (category_id)
#  index_products_on_store_id     (store_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (store_id => stores.id)
#
require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
