class Order < ActiveRecord::Base
  belongs_to :order_status
  belongs_to :store
  has_many :order_items
  before_create :set_order_status
  before_save :update_subtotal

  def subtotal
    order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
  end
  def total
    subtotal + self[:tax].to_i + self[:shipping].to_i
  end

private
  def set_order_status
    self.order_status_id = 1
    self.number_of_transactions = 0
  end

  def update_subtotal
    self[:subtotal] = subtotal
    self[:total] = total

  end
end
