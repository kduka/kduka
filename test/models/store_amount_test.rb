# == Schema Information
#
# Table name: store_amounts
#
#  id                :integer          not null, primary key
#  actual            :integer          default(0)
#  amount            :integer          default(0)
#  lifetime_earnings :integer          default(0)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  store_id          :integer
#
# Indexes
#
#  index_store_amounts_on_store_id  (store_id)
#
# Foreign Keys
#
#  fk_rails_...  (store_id => stores.id)
#
require 'test_helper'

class StoreAmountTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
