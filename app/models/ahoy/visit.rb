class Ahoy::Visit < ApplicationRecord
  self.table_name = "ahoy_visits"

  has_many :events, class_name: "Ahoy::Event"
  belongs_to :user, optional: true

  before_save :finalize


  def finalize
  self[:utm_campaign] = "TEMP"
  end


end
