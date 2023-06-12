class Room < ApplicationRecord
  belongs_to :festival
  has_many :room_requirements, dependent: :destroy
  has_many :requirements, through: :room_requirements
  has_many :rehearsals, dependent: :destroy
  validates :name, uniqueness: true, presence: true
  validates :size, presence: true, comparison: { greater_than: 0 }
  # scope for creating a custom query of the database. Show new created items on top.
  scope :ordered, -> { order(created_at: :desc) }
end
