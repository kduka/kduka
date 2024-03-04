# == Schema Information
#
# Table name: sub_categories
#
#  id          :integer          not null, primary key
#  active      :boolean
#  description :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#
# Indexes
#
#  index_sub_categories_on_category_id  (category_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#
class SubCategory < ApplicationRecord
  belongs_to :category
end
