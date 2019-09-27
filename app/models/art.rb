class Art < ApplicationRecord
  belongs_to :artist

  mount_uploader :photo, PhotoUploader
  has_attachments :photos, maximum: 5


  has_many :art_tags
  has_many :comments
  has_many :likes
  has_many :reactions
  has_many :cart_products
  has_one :photos, dependent: :destroy
  # has_one :photos

  validates :description,  presence: true
  validates :title,  presence: true
  validates :photo, presence: true




end
