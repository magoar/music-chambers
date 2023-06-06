class Musician < ApplicationRecord
  has_many :musician_requirements
  has_many :requirements, through: :musician_requirements
  has_many :groups, through: :members
end
