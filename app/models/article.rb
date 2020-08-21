class Article < ApplicationRecord
  # extend FriendlyId
  # friendly_id :title, use: :slugged

  belongs_to :artist
  has_rich_text :content
  has_one_attached :photo

  # mount_uploader :photo, PhotoUploader


  validates :title, presence: true
  validates :photo, presence: true
  validates :content, presence: true

end
