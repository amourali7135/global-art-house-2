class Artist < ApplicationRecord
  belongs_to :user
  mount_uploader :photo, PhotoUploader
  geocoded_by :country
  geocoded_by :city
  after_validation :geocode, if: :will_save_change_to_country?
  after_validation :geocode, if: :will_save_change_to_city?
  acts_as_followable
  acts_as_votable


  def mailboxer_email(object)
    email
  end



  has_many :arts, dependent: :destroy
  has_many :languages
  has_many :orders
  has_one :photo, dependent: :destroy
  has_many :artist_tags, dependent: :destroy
  has_many :tags, through: :artist_tags, dependent: :destroy

  validates :age, presence: true
  validates :bio, presence: true
  validates :city, presence: true
  validates :country, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  # validates :tag_ids, presence: true

  def self.tagged_with(name)
    Tag.find_by!(name: name).artists
  end

  def self.tag_counts
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

#     include PgSearch::Model
#   pg_search_scope :global_search,
#   against: [ :first_name, :last_name, :artist_name, :bio, :birth_place, :city, :country, :form ] #tags!
#   art: [ :title, :description, :inspiration, :styles, :tags, :art_tags ], #tags!
#   associated_against: {
# },
# using: {
# tsearch: { prefix: true }
# }
end



