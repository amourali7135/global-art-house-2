class Collaboration < ApplicationRecord

  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :artist

  mount_uploader :photo, PhotoUploader


  validates :title, presence: true
  # validates :photo, presence: true
  validates :description, presence: true
  validates :goal, presence: true

  acts_as_punchable
  acts_as_votable
end

