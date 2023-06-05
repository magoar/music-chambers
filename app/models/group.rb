class Group < ApplicationRecord
  belongs_to :festival
  has_many :rehearsals
  has_many :musicians, through: :members
end
