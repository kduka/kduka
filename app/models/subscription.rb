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
#  status                 :integer          default(0)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  store_id               :integer
#
# Indexes
#
#  index_subscriptions_on_store_id  (store_id)
#
# Foreign Keys
#
#  fk_rails_...  (store_id => stores.id)
#
class Subscription < ApplicationRecord
  # --- concerns ---
  include OrderStatusable

  # --- associations ---
  belongs_to :store
  has_many :invoice, :dependent => :destroy
  has_many :subscription_record, :dependent => :destroy
end
