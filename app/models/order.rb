class Order < ApplicationRecord
  belongs_to :user
  belongs_to :art

  monetize :amount_cents
  mount_uploader :photo, PhotoUploader
end
