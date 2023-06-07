class Group < ApplicationRecord
  belongs_to :festival
  has_many :rehearsals, dependent: :destroy
  has_many :members, dependent: :destroy
  has_many :musicians, through: :members
  has_many :requirements, -> { distinct }, through: :musicians
  validates :name, presence: true
end
