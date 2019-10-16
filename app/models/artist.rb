class Artist < ApplicationRecord
  belongs_to :user, optional: true
  mount_uploader :photo, PhotoUploader
  geocoded_by :country
  geocoded_by :city
  after_validation :geocode, if: :will_save_change_to_country?
  after_validation :geocode, if: :will_save_change_to_city?
  acts_as_followable
  acts_as_votable
  # acts_as_taggable_on :forms, :country, :city

  #maybe a deletion problem.
  has_many :arts, dependent: :destroy
  has_many :languages
  has_many :orders
  has_one :photo, dependent: :destroy


  validates :age, presence: true
  validates :bio, presence: true
  validates :city, presence: true
  validates :country, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :form, presence: true
  # validates :photo, presence:true, presence: true, on: :update

  


end
