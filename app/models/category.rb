class Category < ApplicationRecord
  belongs_to :store
  has_many :sub_category, :dependent => :destroy
end
