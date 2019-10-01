class Art < ApplicationRecord
  belongs_to :artist
  
  acts_as_taggable_on :tags
  acts_as_likeable
  acts_as_mentionable

  
  
  Gutentag::ActiveRecord.call self
  
  mount_uploader :photo, PhotoUploader
  
  # has_many :art_tags
  has_many :cart_products
  has_many :comments, -> {order(:created_at => :desc)}
  # has_many :likes
  has_one :photos, dependent: :destroy
  # has_many :reactions
  # has_one :photos
  
  has_many :comments, dependent: :destroy
  
  
  validates :description,  presence: true
  validates :photo, presence: true
  validates :title,  presence: true
  
  
  # This also goes in your model.
  
  # # Return the tag names separated by a comma and space
  # def tags_as_string
  #   tag_names.join(", ")
  # end
  
  # # Split up the provided value by commas and (optional) spaces.
  # def tags_as_string=(string)
  #   self.tag_names = string.split(/,\s*/)
  # end
  
  
end
