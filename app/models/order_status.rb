# == Schema Information
#
# Table name: order_statuses
#
#  id         :integer          not null, primary key
#  name       :string
#  status     :integer          default(0)
#  created_at :datetime
#  updated_at :datetime
#
class OrderStatus < ActiveRecord::Base
  has_many :orders
end
