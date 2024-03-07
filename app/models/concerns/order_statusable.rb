module OrderStatusable
  extend ActiveSupport::Concern

  included do
    enum status: {
      in_progress: 0,
      placed: 1,
      shipped: 2,
      cancelled: 3,
      pending: 4,
      completed: 5
    }
  end
end