class Layout < ApplicationRecord
  mount_uploader :preview, PreviewUploader
end
