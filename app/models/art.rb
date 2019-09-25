class Art < ApplicationRecord
  belongs_to :artist

  has_many :art_tags
  has_many :comments
  has_many :likes
  has_many :reactions
  has_many :cart_products

  validates :description, presence: true
  validates :title, presence: true


end
