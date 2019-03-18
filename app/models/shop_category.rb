class ShopCategory < ApplicationRecord
  validates :shop_category, uniqueness: {case_sensitive: false}
  has_many :stores



end
