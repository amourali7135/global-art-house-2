class Service < ApplicationRecord
  belongs_to :artist

  mount_uploader :photo, PhotoUploader


  validates :title, presence: true
  validates :length, presence: true
  validates :description, presence: true
  validates :price_cents, presence: true

end
