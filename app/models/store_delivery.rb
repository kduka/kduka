# == Schema Information
#
# Table name: store_deliveries
#
#  id             :integer          not null, primary key
#  delivery_areas :string
#  price          :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  store_id       :integer
#
# Indexes
#
#  index_store_deliveries_on_store_id  (store_id)
#
# Foreign Keys
#
#  fk_rails_...  (store_id => stores.id)
#
class StoreDelivery < ApplicationRecord
  belongs_to :store
end
