# == Schema Information
#
# Table name: subscriptions
#
#  id                     :integer          not null, primary key
#  amount                 :integer
#  description            :string
#  number_of_transactions :integer          default(0)
#  received               :integer          default(0)
#  ref                    :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  order_status_id        :integer
#  store_id               :integer
#
# Indexes
#
#  index_subscriptions_on_order_status_id  (order_status_id)
#  index_subscriptions_on_store_id         (store_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_status_id => order_statuses.id)
#  fk_rails_...  (store_id => stores.id)
#
require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
