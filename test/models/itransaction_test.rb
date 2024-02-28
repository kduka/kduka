# == Schema Information
#
# Table name: itransactions
#
#  id                :integer          not null, primary key
#  amount            :string
#  balance_as_of_now :string
#  reference         :string
#  status            :string
#  text              :string
#  timestamp         :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  store_id          :integer
#
# Indexes
#
#  index_itransactions_on_store_id  (store_id)
#
# Foreign Keys
#
#  fk_rails_...  (store_id => stores.id)
#
require 'test_helper'

class ItransactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
