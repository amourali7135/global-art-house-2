class Art < ApplicationRecord
  belongs_to :artist

  #acts_as_taggable_on :styles
  acts_as_votable


  #Gutentag::ActiveRecord.call self

  mount_uploader :photo, PhotoUploader

  has_many :cart_products
  has_many :comments, -> {order(:created_at => :desc)}
  has_many :photos, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :art_tags
  has_many :tags, through: :art_tags

  # has_many :pictures, dependent: :destroy


  validates :description,  presence: true
  # validates :photo, presence: true
  validates :title,  presence: true
  validates :styles, presence: true

  monetize :price_cents

  include PgSearch::Model
  pg_search_scope :global_search,
  against: [ :title, :description, :inspiration, :styles ],
  associated_against: {
  artist: [ :first_name, :last_name, :artist_name, :bio, :birth_place, :city, :country, :form ]
},
using: {
tsearch: { prefix: true }
}


def self.tagged_with(name)
    Tag.find_by!(name: name).arts
  end

  def self.tag_counts
    # Tag.select('tags.*, count(art_tags.tag_id) as count').joins(:art_tags).group('art_tags.tag_id')
    self.tags.count
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
end

