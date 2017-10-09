class Product < ActiveRecord::Base
  belongs_to :store
  has_many :order_items
  validates :name, :price, :category_id,:quantity, presence: true
  
  mount_uploader :image, AvatarUploader
  mount_uploader :img1, Img1Uploader

  #default_scope { where(active: true) }
end
