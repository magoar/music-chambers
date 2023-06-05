class Requirement < ApplicationRecord
  has_many :room_requirements
  has_many :musician_requirements
end
