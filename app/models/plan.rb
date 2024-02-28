# == Schema Information
#
# Table name: plans
#
#  id         :integer          not null, primary key
#  amount     :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Plan < ApplicationRecord
end
