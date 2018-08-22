class SubscriptionRecord < ApplicationRecord
  belongs_to :store
  belongs_to :subscription
end
