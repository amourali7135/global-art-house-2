class Job < ApplicationRecord
  belongs_to :user
  mount_uploader :photo, PhotoUploader
  geocoded_by :country
  geocoded_by :city
  after_validation :geocode, if: :will_save_change_to_country?
  after_validation :geocode, if: :will_save_change_to_city?

  validates :title, presence: true
  validates :description, presence: true
  validates :requirements, presence: true
  validates :salary, presence: true
  validates :city, presence: true
  validates :country, presence: true
  validates :company, presence: true
  validates :seniority, presence: true
  validates :industry, presence: true
  validates :benefits, presence: true
  validates :frequency, presence: true
  validates :preferred, presence: true

  include PgSearch::Model
  pg_search_scope :global_search,
  # against: [ :first_name, :last_name, :artist_name, :bio, :birth_place, :city, :country],
  against: [ :bio, :birth_place, :city, :country, :first_name, :last_name, :artist_name ],
  associated_against: {
    tags: [:name],
  },
  using: {
    tsearch: { prefix: true }
  }

  def self.media  #media
    ['Painting', 'Drawing', 'Sculpture', 'Architecture', 'Ceramic', 'Electronic', 'Light', 'Graphic Design', 'Photography', 'Textile', 'Performance', 'Poetry', 'Literature', 'Collage', 'Digital', 'Animation', 'Body', 'Street', 'Graffiti', 'Glass', 'Tapestry', 'Installation', 'Calligraphy', 'Dance', 'Tattoo', 'Furniture', 'Wood', 'Nature', 'Film', 'UX/UI', 'Acting', 'Theater', 'Costumes', 'Music', 'Video Games', 'Music' ].sort
  end

  def self.styles
    ["Abstract", "Realist", "Modern", "Pop", "Cubism", "Deco", "Nouveau", "Surrealism", "Contemporary", "Abstract Expressionism", 'Post-Impressionism', 'Collage', 'Figure Drawing', 'Landscapes', 'Still Life',  'Graffiti', 'Tattoo', 'Experimental', 'Portrait', 'Political', 'Earth', 'National/Nationalist', 'Propaganda', 'Advertising', 'Industrial', 'Agricultural', 'UX/UI', 'Social Justice' ].sort
  end

end
