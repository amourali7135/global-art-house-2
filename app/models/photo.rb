class Photo < ApplicationRecord
  belongs_to :art
  mount_uploader :photo, PhotoUploader
  # has_attached_file :image 

end
