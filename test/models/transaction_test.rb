# == Schema Information
#
# Table name: transactions
#
#  id                    :integer          not null, primary key
#  account               :string
#  amount                :integer
#  balance               :integer
#  bankcode              :string
#  foreign_ref           :string
#  name                  :string
#  ref                   :string
#  trans_type            :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  store_id              :integer
#  transaction_status_id :integer
#
# Indexes
#
#  index_transactions_on_store_id               (store_id)
#  index_transactions_on_transaction_status_id  (transaction_status_id)
#
# Foreign Keys
#
#  fk_rails_...  (store_id => stores.id)
#  fk_rails_...  (transaction_status_id => transaction_statuses.id)
#
require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
