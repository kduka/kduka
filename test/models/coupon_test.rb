# == Schema Information
#
# Table name: coupons
#
#  id            :integer          not null, primary key
#  active        :boolean
#  amount        :integer
#  code          :string
#  coupon_type   :string
#  expiry        :date
#  number_of_use :integer
#  percentage    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  store_id      :integer
#
# Indexes
#
#  index_coupons_on_store_id  (store_id)
#
# Foreign Keys
#
#  fk_rails_...  (store_id => stores.id)
#
require 'test_helper'

class CouponTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
