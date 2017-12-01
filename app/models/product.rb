require 'csv'
class Product < ActiveRecord::Base
  belongs_to :store
  has_many :order_items, :dependent => :destroy
  validates :name, :price, :category_id,:quantity, presence: true
  after_initialize :init

  mount_uploader :image, AvatarUploader
  mount_uploader :img1, Img1Uploader
  mount_uploader :img2, Img2Uploader
  mount_uploader :img3, Img3Uploader
  mount_uploader :img4, Img4Uploader

  def init
    self.viewed  ||= 0
    self.number_sold ||= 0
  end

  def self.to_csv(options = {})
    desired_columns = [ "name", "price", "sku","quantity","description","number_sold","viewed"]
    CSV.generate(options) do |csv|
      csv << desired_columns
      all.each do |product|
        csv << product.attributes.values_at(*desired_columns)
      end
    end
  end

  #default_scope { where(active: true) }
end
