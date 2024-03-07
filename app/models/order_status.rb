# == Schema Information
#
# Table name: order_statuses
#
#  id         :integer          not null, primary key
#  name       :string
#  status     :integer          default("in_progress")
#  created_at :datetime
#  updated_at :datetime
#
class OrderStatus < ActiveRecord::Base
  enum status: {
    in_progress: 0,
    placed: 1,
    shipped: 2,
    cancelled: 3,
    pending: 4,
    completed: 5
  }
  
  has_many :orders
end
