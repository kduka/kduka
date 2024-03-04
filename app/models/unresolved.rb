# == Schema Information
#
# Table name: unresolveds
#
#  id         :integer          not null, primary key
#  transid    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Unresolved < ApplicationRecord
end
