# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  active      :boolean
#  description :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Cat < ApplicationRecord
end
