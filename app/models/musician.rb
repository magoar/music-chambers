class Musician < ApplicationRecord
  has_many :musician_requirements, dependent: :destroy
  has_many :requirements, through: :musician_requirements
  has_many :members, dependent: :destroy
  has_many :groups, through: :members
  has_many :rehearsals, through: :groups
  validates :name, uniqueness: true
end
