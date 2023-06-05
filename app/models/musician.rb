class Musician < ApplicationRecord
  has_many :requirements, through: :musician_requirements
  has_many :groups, through: :members
end
