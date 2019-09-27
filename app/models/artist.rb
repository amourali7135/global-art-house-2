class Artist < ApplicationRecord
  belongs_to :user
  mount_uploader :photo, PhotoUploader
  # has_attachment :photos, maximum: 3
  geocoded_by :country
  geocoded_by :city
  after_validation :geocode, if: :will_save_change_to_country?
  after_validation :geocode, if: :will_save_change_to_city?


  has_many :descriptive_tags
  has_many :arts
  has_many :followers
  has_many :languages
  has_many :likes, dependent: :destroy
  has_many :orders
  has_many :reactions, dependent: :destroy
  has_one :photo, dependent: :destroy

  validates :age, presence: true
  validates :bio, presence: true
  validates :city, presence: true
  # validates :country, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  # validates :photo, presence:true, presence: true, on: :update

end
