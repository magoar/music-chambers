class Room < ApplicationRecord
  belongs_to :festival
  has_many :room_requirements, dependent: :destroy
  has_many :requirements, through: :room_requirements
  has_many :rehearsals, dependent: :destroy
  validates :name, uniqueness: true
  validates :size, comparison: { greater_than: 0 }
end
