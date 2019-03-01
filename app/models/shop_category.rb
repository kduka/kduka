class ShopCategory < ApplicationRecord
  validates :shop_category, uniqueness: {case_sensitive: false}
  mount_uploader :image, ExploreUploader


end
