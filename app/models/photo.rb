class Photo < ApplicationRecord
  belongs_to :art
  mount_uploader :photo, PhotoUploader

end
