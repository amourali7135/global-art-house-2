class Job < ApplicationRecord
  belongs_to :user
  mount_uploader :photo, PhotoUploader
  geocoded_by :country
  geocoded_by :city
  after_validation :geocode, if: :will_save_change_to_country?
  after_validation :geocode, if: :will_save_change_to_city?
  acts_as_taggable_on :tags

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

  #add active scope here.
  scope :currently_active, -> {where("active = true")}

  include PgSearch::Model
  pg_search_scope :global_search,
  against: [  :city, :country, :title, :description, :salary, :remote, :frequency, :seniority, :company ],
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

  def self.seniority
    ['Internship/Apprenticeship', 'Entry-level', 'Mid-level', 'Senior-level', 'Executive', 'Director', 'Chief', 'Associate' ].sort
  end

  def self.industry
    ["Accounting", "Airlines/Aviation","Alternative Dispute Resolution", "Alternative Medicine", "Animation", "Apparel & Fashion", "Architecture & Planning", "Arts and Crafts", "Automotive ","Aviation & Aerospace","Banking","Biotechnology ","Broadcast Media","Building Materials","Business Supplies and Equipment","Capital Markets","Chemicals", "Civic & Social Organization", "Civil Engineering","Commercial Real Estate", "Computer & Network Security", "Computer Games", "Computer Hardware ", "Computer Networking", "Computer Software ", "Construction", "Consumer Electronics", "Consumer Goods", "Consumer Services", "Cosmetics", "Dairy", "Defense & Space ", "Design", "Education Management", "E-Learning", "Electrical/Electronic Manufacturing", "Entertainment ", "Environmental Services ", "Events Services", "Executive Office", "Facilities Services", "Farming", "Financial Services ", "Fine Art", "Fishery", "Food & Beverages ", "Food Production", "Fund-Raising", "Furniture ", "Gambling & Casinos", "Glass, Ceramics & Concrete", "Government Administration", "Government Relations", "Graphic Design", "Health, Wellness and Fitness ", "Higher Education", "Hospital & Health Care ", "Hospitality", "Human Resources ", "Import and Export", "Individual & Family Services", "Industrial Automation", "Information Services", "Information Technology and Services ", "Insurance ", "International Affairs", "International Trade and Development", "Internet ", "Investment Banking", "Investment Management", "Judiciary", "Law Enforcement", "Law Practice ", "Legal Services", "Legislative Office", "Leisure, Travel & Tourism", "Libraries", "Logistics and Supply Chain", "Luxury Goods & Jewelry ", "Machinery", "Management Consulting", "Maritime", "Market Research", "Marketing and Advertising", "Mechanical or Industrial Engineering", "Media Production", "Medical Devices ", "Medical Practice ", "Mental Health Care ", "Military ", "Mining & Metals", "Motion Pictures and Film", "Museums and Institutions", "Music ", "Nanotechnology", "Newspapers", "Non-Profit Organization Management", "Oil & Energy", "Online Media", "Outsourcing/Offshoring ", "Package/Freight Delivery", "Packaging and Containers", "Paper & Forest Products", "Performing Arts", "Pharmaceuticals", "Philanthropy", "Photography", "Plastics", "Political Organization", "Primary/Secondary Education", "Printing", "Professional Training & Coaching", "Program Development", "Public Policy" "Public Relations and Communications", "Public Safety", "Publishing ", "Railroad Manufacture", "Ranching", "Real Estate ", "Recreational Facilities and Services", "Religious Institutions", "Renewables & Environment", "Research", "Restaurants", "Retail", "Security and Investigations", "Semiconductors", "Shipbuilding", "Sporting Goods", "Sports", "Staffing and Recruiting ", "Supermarkets", "Telecommunications ", "Textiles", "Think Tanks", "Tobacco", 'Translation and Localization', "Transportation/Trucking/Railroad ", "Utilities", "Venture Capital & Private Equity", "Veterinary", "Warehousing" , "Wholesale", "Wine and Spirits", "Wireless", "Writing and Editing" ].sort
  end

  def self.frequency
    ['Part-time', 'Full-time'].sort
  end

end
