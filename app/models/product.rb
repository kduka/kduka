# == Schema Information
#
# Table name: products
#
#  id               :integer          not null, primary key
#  active           :boolean
#  additional_info  :string
#  description      :text
#  discount_price   :integer
#  discount_status  :boolean          default(FALSE)
#  height           :integer
#  image            :string
#  img1             :string
#  img2             :string
#  img3             :string
#  img4             :string
#  length           :integer
#  long_description :text
#  name             :string
#  number_sold      :integer
#  price            :decimal(12, 3)
#  quantity         :integer
#  sku              :string
#  viewed           :integer
#  weight           :integer
#  width            :integer
#  created_at       :datetime
#  updated_at       :datetime
#  category_id      :integer
#  store_id         :integer
#
# Indexes
#
#  index_products_on_category_id  (category_id)
#  index_products_on_store_id     (store_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (store_id => stores.id)
#
require 'csv'
class Product < ActiveRecord::Base
  belongs_to :store
  has_many :order_items, :dependent => :destroy
  has_many :variant, :dependent => :destroy
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
