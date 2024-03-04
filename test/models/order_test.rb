# == Schema Information
#
# Table name: orders
#
#  id                     :integer          not null, primary key
#  address                :string
#  amount_received        :integer
#  complete_date          :datetime
#  coupon                 :string
#  coupon_status          :boolean          default(FALSE)
#  date_placed            :datetime
#  date_placed2           :date
#  del_lat                :string
#  del_location           :string
#  del_long               :string
#  delivery_code          :string
#  delivery_order         :string
#  delivery_type          :string
#  discount               :integer          default(0)
#  email                  :string
#  name                   :string
#  number_of_transactions :integer
#  order_instructions     :text
#  phone                  :string
#  read                   :boolean          default(FALSE)
#  ref                    :string
#  ship_date              :datetime
#  shipping               :decimal(12, 3)
#  status                 :integer          default("in_progress")
#  subtotal               :decimal(12, 3)
#  tax                    :decimal(12, 3)
#  total                  :decimal(12, 3)
#  created_at             :datetime
#  updated_at             :datetime
#  store_id               :integer
#
# Indexes
#
#  index_orders_on_store_id  (store_id)
#
# Foreign Keys
#
#  fk_rails_...  (store_id => stores.id)
#
require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
