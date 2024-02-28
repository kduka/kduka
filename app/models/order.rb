# == Schema Information
#
# Table name: orders
#
#  id                     :integer          not null, primary key
#  address                :string
#  amount_received        :integer
#  complete_date          :datetime
#  coupon                 :string
#  coupon_status          :boolean          default(FALSE)
#  date_placed            :datetime
#  date_placed2           :date
#  del_lat                :string
#  del_location           :string
#  del_long               :string
#  delivery_code          :string
#  delivery_order         :string
#  delivery_type          :string
#  discount               :integer          default(0)
#  email                  :string
#  name                   :string
#  number_of_transactions :integer
#  order_instructions     :text
#  phone                  :string
#  read                   :boolean          default(FALSE)
#  ref                    :string
#  ship_date              :datetime
#  shipping               :decimal(12, 3)
#  status                 :integer          default("in_progress")
#  subtotal               :decimal(12, 3)
#  tax                    :decimal(12, 3)
#  total                  :decimal(12, 3)
#  created_at             :datetime
#  updated_at             :datetime
#  store_id               :integer
#
# Indexes
#
#  index_orders_on_store_id  (store_id)
#
# Foreign Keys
#
#  fk_rails_...  (store_id => stores.id)
#
class Order < ActiveRecord::Base
  belongs_to :store
  has_many :order_items, :dependent => :destroy
  before_create :set_order_details
  before_save :update_subtotal

  def subtotal
    order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
  end
  def total
    subtotal + self[:tax].to_i + self[:shipping].to_i - self[:discount].to_i
  end

  enum status: {
    in_progress: 0,
    placed: 1,
    shipped: 2,
    cancelled: 3,
    pending: 4,
    completed: 5
  }

private
  def set_order_details
    self.number_of_transactions = 0
    self.tax = 0
  end

  def update_subtotal
    self[:subtotal] = subtotal
    self[:total] = total

  end
end
