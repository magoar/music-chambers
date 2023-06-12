class Group < ApplicationRecord
  belongs_to :festival
  has_many :rehearsals, dependent: :destroy
  has_many :members, dependent: :destroy
  has_many :musicians, through: :members
  has_many :requirements, -> { distinct }, through: :musicians
  validates :name, presence: true
  # scope for creating a custom query of the database. Show new created items on top.
  scope :ordered, -> { order(created_at: :desc) }
end
