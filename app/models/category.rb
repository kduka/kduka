# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  active      :boolean
#  description :string
#  featured    :boolean
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  store_id    :integer
#
# Indexes
#
#  index_categories_on_store_id  (store_id)
#
# Foreign Keys
#
#  fk_rails_...  (store_id => stores.id)
#
class Category < ApplicationRecord
  before_save :init
  belongs_to :store
  has_many :sub_category, :dependent => :destroy
  has_many :product, :dependent => :destroy

  def init
    if self.active.nil?
      self.active = true
    end
  end
end
