class Requirement < ApplicationRecord
  has_many :room_requirements, dependent: :destroy
  has_many :rooms, through: :room_requirements
  has_many :musician_requirements, dependent: :destroy
  has_many :musicians, through: :musician_requirements
  validates :name, uniqueness: true
end
