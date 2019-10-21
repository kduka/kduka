class Subscription < ApplicationRecord
  belongs_to :store
  belongs_to :order_status

  has_many :invoice, :dependent => :destroy
  has_many :subscription_record, :dependent => :destroy
end
