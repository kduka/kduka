class Category < ApplicationRecord
  before_save :init
  belongs_to :store
  has_many :sub_category, :dependent => :destroy

  def init
    if self.active.nil?
      self.active = true
    end
  end
end
