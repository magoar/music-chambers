class Group < ApplicationRecord
  belongs_to :festival
  has_many :rehearsals
  has_many :members
  has_many :musicians, through: :members
  has_many :requirements, through: :musicians
end
