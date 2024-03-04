# == Schema Information
#
# Table name: order_statuses
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime
#  updated_at :datetime
#
class OrderStatus < ActiveRecord::Base
  has_many :orders
end
