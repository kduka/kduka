# == Schema Information
#
# Table name: subscription_records
#
#  id              :integer          not null, primary key
#  description     :string
#  expire          :date
#  start           :date
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  store_id        :integer
#  subscription_id :integer
#
# Indexes
#
#  index_subscription_records_on_store_id         (store_id)
#  index_subscription_records_on_subscription_id  (subscription_id)
#
# Foreign Keys
#
#  fk_rails_...  (store_id => stores.id)
#  fk_rails_...  (subscription_id => subscriptions.id)
#
class SubscriptionRecord < ApplicationRecord
  belongs_to :store
  belongs_to :subscription
end
