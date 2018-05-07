class Store < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :product, :dependent => :destroy
  has_many :category, :dependent => :destroy
  has_many :coupon, :dependent => :destroy
  has_one :store_amount, :dependent => :destroy

  mount_uploader :banner, BannerUploader
  mount_uploader :logo, LogoUploader
end
