class Tag < ApplicationRecord
  attr_reader :category, :kind, :type
  # has_many :art_taggings
  # has_many :artist_taggings
  has_many :artists, through: :artist_tags
  has_many :arts, through: :art_tags
  # validates_presence_of :art_tagging, unless: :artist_tagging

  def self.art_kinds
    ['Painting', 'Drawing', 'Sculpting', 'Architecture', 'Ceramic', 'Electronic', 'Light', 'Graphic', 'Photography', 'Textile', 'Performance', 'Poetry', 'Literature', 'Collage', 'Digital', 'Animation', 'Body', 'Street', 'Graffiti', 'Glass', 'Tapestry', 'Installation', 'Calligraphy', 'Dance', '' ].sort
  end

  def self.art_types
    ["Abstract", "Realist", "Modern", "Pop", "Cubism", "Deco", "Nouveau", "Surrealism", "Contemporary", "Abstract Expressionism", 'Post-Impressionism', 'Collage', 'Figure Drawing', 'Landscapes', 'Still Life',  'Graffiti', ].sort
  end
end
