# == Schema Information
#
# Table name: transactions
#
#  id          :integer          not null, primary key
#  account     :string
#  amount      :integer
#  balance     :integer
#  bankcode    :string
#  foreign_ref :string
#  name        :string
#  ref         :string
#  status      :integer          default("pending")
#  trans_type  :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  store_id    :integer
#
# Indexes
#
#  index_transactions_on_store_id  (store_id)
#
# Foreign Keys
#
#  fk_rails_...  (store_id => stores.id)
#
class Transaction < ApplicationRecord
  # ---concerns---
  include TransactionStatusable

  # --- associations---
  belongs_to :store
end
