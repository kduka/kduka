# == Schema Information
#
# Table name: feedbacks
#
#  id         :integer          not null, primary key
#  feedback   :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  store_id   :integer
#
# Indexes
#
#  index_feedbacks_on_store_id  (store_id)
#
# Foreign Keys
#
#  fk_rails_...  (store_id => stores.id)
#
class Feedback < ApplicationRecord
  belongs_to :store
end
