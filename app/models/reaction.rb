class Reaction < ApplicationRecord
  belongs_to :art
  has_many :reaction_types
end
