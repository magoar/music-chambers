class Room < ApplicationRecord
  belongs_to :festival
  has_many :room_requirements, dependent: :destroy
  has_many :requirements, through: :room_requirements
  has_many :rehearsals, dependent: :destroy
  validates :name, uniqueness: true, presence: true
  validates :size, presence: true, comparison: { greater_than: 0 }
end
