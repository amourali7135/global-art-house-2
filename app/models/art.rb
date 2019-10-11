class Art < ApplicationRecord
  belongs_to :artist, dependent: :destroy
  
  acts_as_taggable_on :tags
  # acts_as_likeable
  # acts_as_mentionable
  acts_as_votable
  
  
  Gutentag::ActiveRecord.call self
  
  mount_uploader :photo, PhotoUploader
  
  has_many :cart_products
  has_many :comments, -> {order(:created_at => :desc)}
  has_many :photos, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  
  validates :description,  presence: true
  # validates :photo, presence: true
  validates :title,  presence: true
  validates :styles, presence: true
  
  include PgSearch::Model
  pg_search_scope :global_search,
  against: [ :title, :description, :inspiration, :styles ],
  associated_against: {
  artist: [ :first_name, :last_name, :artist_name, :bio, :birth_place, :city, :country, :form ]
},
using: {
tsearch: { prefix: true }
}



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
