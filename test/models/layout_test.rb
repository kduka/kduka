# == Schema Information
#
# Table name: layouts
#
#  id          :integer          not null, primary key
#  d_name      :string
#  description :string
#  name        :string
#  premium     :boolean          default(FALSE)
#  preview     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'test_helper'

class LayoutTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
