class Subscription < ApplicationRecord
  belongs_to :store
  belongs_to :order_status
end
