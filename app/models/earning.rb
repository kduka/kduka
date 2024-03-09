# == Schema Information
#
# Table name: earnings
#
#  id         :integer          not null, primary key
#  amount     :integer
#  ref        :string
#  status     :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  store_id   :integer
#  trans_id   :string
#
# Indexes
#
#  index_earnings_on_store_id  (store_id)
#
# Foreign Keys
#
#  fk_rails_...  (store_id => stores.id)
#
class Earning < ApplicationRecord

  # ---concerns---
  include TransactionStatusable

  # ---associations---
  belongs_to :store
end
