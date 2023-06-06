class Room < ApplicationRecord
  belongs_to :festival
  has_many :room_requirements
  has_many :requirements, through: :room_requirements
  has_many :rehearsals
end
