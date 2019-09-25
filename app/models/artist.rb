class Artist < ApplicationRecord
belongs_to :user

  has_many :arts, dependent: :destroy
  has_many :descriptive_tags
  has_many :followers
  has_many :languages
  has_many :likes, dependent: :destroy
  has_many :orders
  has_many :reactions, dependent: :destroy

  validates :age, presence:true, presence: true, on: :update
  validates :bio, presence:true, presence: true, on: :update
  validates :city, presence:true, presence: true, on: :update
  validates :country, presence:true, presence: true, on: :update
  validates :first_name, presence:true, presence: true, on: :update
  validates :last_name, presence:true, presence: true, on: :update
  # validates :photo, presence:true, presence: true, on: :update

end
