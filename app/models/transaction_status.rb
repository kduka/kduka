# == Schema Information
#
# Table name: transaction_statuses
#
#  id         :integer          not null, primary key
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class TransactionStatus < ApplicationRecord
end
