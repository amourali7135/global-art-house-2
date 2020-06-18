class Art < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :artist

  acts_as_votable

  mount_uploader :photo, PhotoUploader

  has_many :cart_products
  has_many :comments, -> {order(:created_at => :desc)}
  # has_many :photos, dependent: :destroy
  has_many :comments, dependent: :destroy
  # has_many :art_tags, dependent: :destroy
  # has_many :tags, through: :art_tags, dependent: :destroy
  # has_one_attached :photo
  # has_one :photo, dependent: :destroy  #Cancels out the photo uploader!



  validates :title,  presence: true
  validates :description,  presence: true
  validates :photo,  presence: true
  # validates :styles, presence: true


  monetize :price_cents

  acts_as_punchable

  acts_as_taggable_on :tags

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


  #   def self.tagged_with(name)
  #     Tag.find_by!(name: name).arts
  #   end

  #   def self.tag_counts
  #     # Tag.select('tags.*, count(art_tags.tag_id) as count').joins(:art_tags).group('art_tags.tag_id')
  #     self.tags.count
  #   end

  #   def tag_list
  #     tags.map(&:name).join(', ')
  #   end

  #   def tag_list=(names)
  #     self.tags = names.split(',').map do |n|
  #       Tag.where(name: n.strip).first_or_create!
  #     end
  #   end
  # end

  # def comments_sort
  #   @arts.sort_by { |art| -art.comments.count }.each do |art|
  #     render partial: 'shared/art_card', locals: {art: art, artist: art.artist}
  #   end
  # end

  def self.media  #media
    ['Painting', 'Drawing', 'Sculpture', 'Architecture', 'Ceramic', 'Electronic', 'Light', 'Graphic Design', 'Photography', 'Textile', 'Performance', 'Poetry', 'Literature', 'Collage', 'Digital', 'Animation', 'Body', 'Street', 'Graffiti', 'Glass', 'Tapestry', 'Installation', 'Calligraphy', 'Dance', 'Tattoo', 'Furniture', 'Wood', 'Nature', 'Film', 'UX/UI', 'Acting', 'Theater', 'Costumes', 'Music', 'Video Games' ].sort
  end

  def self.styles
    ["Abstract", "Realist", "Modern", "Pop", "Cubism", "Deco", "Nouveau", "Surrealism", "Contemporary", "Abstract Expressionism", 'Post-Impressionism', 'Collage', 'Figure Drawing', 'Landscapes', 'Still Life',  'Graffiti', 'Tattoo', 'Experimental', 'Portrait', 'Political', 'Earth', 'National/Nationalist', 'Propaganda', 'Advertising', 'Industrial', 'Agricultural', 'UX/UI' ].sort
  end


  # def sorted
  # end

end
