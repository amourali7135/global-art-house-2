class Service < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :artist

  mount_uploader :photo, PhotoUploader


  validates :title, presence: true
  validates :length, presence: true
  validates :description, presence: true
  validates :price_cents, presence: true

  acts_as_punchable
  acts_as_votable
  acts_as_taggable_on :tags
  acts_as_commontable dependent: :destroy


  include PgSearch::Model
  pg_search_scope :global_search,
  # against: [  ],
  against: [ :title, :description ],
  associated_against: {
    artist: [  :artist_name, :first_name, :last_name, :city, :country ],
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

  def self.types
    ["Class", "Lesson", "Tutorial", "Mentoring", ""].sort
  end

end
