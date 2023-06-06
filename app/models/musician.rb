class Musician < ApplicationRecord
  has_many :musician_requirements
  has_many :requirements, through: :musician_requirements
  has_many :members
  has_many :groups, through: :members
  has_many :rehearsals, through: :groups
end
