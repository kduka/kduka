class Product < ActiveRecord::Base
  belongs_to :store
  has_many :order_items
  
  mount_uploader :image, AvatarUploader


  default_scope { where(active: true) }
end
