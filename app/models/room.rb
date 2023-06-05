class Room < ApplicationRecord
  belongs_to :festival
  has_many :rehearsals
  has_many :requirements, through: :room_requirements
end
