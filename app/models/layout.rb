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
class Layout < ApplicationRecord
  mount_uploader :preview, PreviewUploader
end
