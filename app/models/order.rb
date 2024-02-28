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
