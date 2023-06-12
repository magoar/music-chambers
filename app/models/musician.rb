class Musician < ApplicationRecord
  belongs_to :festival
  has_many :musician_requirements, dependent: :destroy
  has_many :requirements, through: :musician_requirements
  has_many :members, dependent: :destroy
  has_many :groups, through: :members
  has_many :rehearsals, through: :groups
  # name validations
  validates :name, presence: true
  validates_uniqueness_of :name, scope: :festival_id
  validates :instrument, presence: true
  # scope for creating a custom query of the database. Show new created items on top.
  scope :ordered, -> { order(created_at: :desc) }
end
