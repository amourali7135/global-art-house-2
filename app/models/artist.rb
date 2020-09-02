class Artist < ApplicationRecord
  extend FriendlyId
  friendly_id :artist_name, use: :slugged

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
  has_many :articles, dependent: :destroy
  has_many :services, dependent: :destroy
  has_many :collaborations, dependent: :destroy
  # has_many :orders
  # has_one :photo, dependent: :destroy  #Can break shit like in the art model!

  validates :age, presence: true
  validates :bio, presence: true
  validates :city, presence: true
  validates :country, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :artist_name, uniqueness: true  #Taken away for now because of seeding data repeats
  validates :artist_name, presence: true #Do custom validation for the slug
  validates :photo, presence: true

  acts_as_punchable
  acts_as_taggable_on :tags
  acts_as_commontator


  include PgSearch::Model
  pg_search_scope :global_search,
  # against: [ :first_name, :last_name, :artist_name, :bio, :birth_place, :city, :country],
  against: [ :bio, :birth_place, :city, :country],
  associated_against: {
    tags: [:name],
  },
  using: {
    tsearch: { prefix: true }
  }

  #Sortable menu experiment for search sorts.

  # def self.followers
  #   all.sort_by { |a| a.followers.count}
  # end

  # def self.recent
  #   all.sort_by { |a| a.created_at}.reverse
  # end

  # def self.views
  #   all.sort_by { |a| a.hits}
  # end

  # def self.likes
  #   all.sort_by { |a| a.get_likes.size}
  # end

  # def self.sorted
  #   [self.followers, self.recent, self.views, self.likes]
  # end

  def self.media  #media
    ['Painting', 'Drawing', 'Sculpture', 'Architecture', 'Ceramic', 'Electronic', 'Light', 'Graphic Design', 'Photography', 'Textile', 'Performance', 'Poetry', 'Literature', 'Collage', 'Digital', 'Animation', 'Body', 'Street', 'Graffiti', 'Glass', 'Tapestry', 'Installation', 'Calligraphy', 'Dance', 'Tattoo', 'Furniture', 'Wood', 'Nature', 'Film', 'UX/UI', 'Acting', 'Theater', 'Costumes', 'Music', 'Video Games', 'Music' ].sort
  end

  def self.styles
    ["Abstract", "Realist", "Modern", "Pop", "Cubism", "Deco", "Nouveau", "Surrealism", "Contemporary", "Abstract Expressionism", 'Post-Impressionism', 'Collage', 'Figure Drawing', 'Landscapes', 'Still Life',  'Graffiti', 'Tattoo', 'Experimental', 'Portrait', 'Political', 'Earth', 'National/Nationalist', 'Propaganda', 'Advertising', 'Industrial', 'Agricultural', 'UX/UI', 'Social Justice' ].sort
  end

  #check this though.
  def self.form_list
    form_array = []
    @artist.form each do |form|
      form_array << form
    end
  end

  def self.newbie
    @artist.arts.count = 0
  end

end




