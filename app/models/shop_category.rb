# == Schema Information
#
# Table name: shop_categories
#
#  id            :integer          not null, primary key
#  shop_category :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_shop_categories_on_shop_category  (shop_category) UNIQUE
#
class ShopCategory < ApplicationRecord
  validates :shop_category, uniqueness: {case_sensitive: false}
  has_many :stores



end
