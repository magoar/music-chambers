class Requirement < ApplicationRecord
  has_many :room_requirements
  has_many :rooms, through: :room_requirements
  has_many :musician_requirements
  has_many :musicians, through: :musician_requirements
end
