class Art < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :artist

  acts_as_votable

  mount_uploader :photo, PhotoUploader

  has_many :cart_products
  # has_many :comments, -> {order(:created_at => :desc)}
  # has_many :comments, dependent: :destroy
  # has_one :photo, dependent: :destroy  #Cancels out the photo uploader!

  validates :title,  presence: true
  validates :description,  presence: true
  validates :photo,  presence: true
  # validates :styles, presence: true


  monetize :price_cents

  acts_as_punchable
  acts_as_taggable_on :tags
  acts_as_commontable dependent: :destroy



  include PgSearch::Model
  pg_search_scope :global_search,
  against: [  ], #still iffy about :description, :inspiration
  # against: [ :title, :description, :inspiration, :styles ],
  associated_against: {
    artist: [  :city, :country ],
    tags: [:name],
  },
  using: {
    tsearch: { prefix: true }
  }


  # def comments_sort
  #   @arts.sort_by { |art| -art.comments.count }.each do |art|
  #     render partial: 'shared/art_card', locals: {art: art, artist: art.artist}
  #   end
  # end

  def self.media  #media
    ['Painting', 'Drawing', 'Sculpture', 'Architecture', 'Ceramic', 'Electronic', 'Light', 'Graphic Design', 'Photography', 'Textile', 'Performance', 'Poetry', 'Literature', 'Collage', 'Digital', 'Animation', 'Body', 'Street', 'Graffiti', 'Glass', 'Tapestry', 'Installation', 'Calligraphy', 'Dance', 'Tattoo', 'Furniture', 'Wood', 'Nature', 'Film', 'UX/UI', 'Acting', 'Theater', 'Costumes', 'Music', 'Video Games', 'Music' ].sort
  end

  def self.styles
    ["Abstract", "Realist", "Modern", "Pop", "Cubism", "Deco", "Nouveau", "Surrealism", "Contemporary", "Abstract Expressionism", 'Post-Impressionism', 'Collage', 'Figure Drawing', 'Landscapes', 'Still Life',  'Graffiti', 'Tattoo', 'Experimental', 'Portrait', 'Political', 'Earth', 'National/Nationalist', 'Propaganda', 'Advertising', 'Industrial', 'Agricultural', 'UX/UI', 'Social Justice' ].sort
  end


end
