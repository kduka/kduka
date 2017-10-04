class Store < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :product, :dependent => :destroy
  has_many :category, :dependent => :destroy

  mount_uploader :banner, BannerUploader
  mount_uploader :logo, LogoUploader
end
