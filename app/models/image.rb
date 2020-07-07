class Image < ApplicationRecord
  belongs_to :product, inverse_of: :images
  mount_uploaders :image, ImageUploader
end
