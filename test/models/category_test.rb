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
require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
