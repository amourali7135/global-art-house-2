class Tag < ApplicationRecord
  attr_reader :category, :kind, :type
  has_many :art_tags #Added after strange error on 111519, check into it later.
  has_many :artist_tags #Added after strange error on 111519, check into it later.
  has_many :artists, through: :artist_tags
  has_many :arts, through: :art_tags


  def self.art_kinds
    ['Painting', 'Drawing', 'Sculpting', 'Architecture', 'Ceramic', 'Electronic', 'Light', 'Graphic', 'Photography', 'Textile', 'Performance', 'Poetry', 'Literature', 'Collage', 'Digital', 'Animation', 'Body', 'Street', 'Graffiti', 'Glass', 'Tapestry', 'Installation', 'Calligraphy', 'Dance', 'Tattoo', 'Furniture', 'Wood', 'Nature', ].sort
  end

  def self.art_types
    ["Abstract", "Realist", "Modern", "Pop", "Cubism", "Deco", "Nouveau", "Surrealism", "Contemporary", "Abstract Expressionism", 'Post-Impressionism', 'Collage', 'Figure Drawing', 'Landscapes', 'Still Life',  'Graffiti', 'Tattoo', 'Experimental', 'Portrait', 'Political',  ].sort
  end
end
