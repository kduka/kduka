module TransactionStatusable
  extend ActiveSupport::Concern

  included do
    enum status: {
      pending: 0,
      success: 1,
      failed: 2
    }
  end
end