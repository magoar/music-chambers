class Festival < ApplicationRecord
  belongs_to :user
  has_many :rooms, dependent: :destroy
  has_many :groups, dependent: :destroy
  has_many :musicians, dependent: :destroy
  has_many :rehearsals, dependent: :destroy
  has_many :timeslots, dependent: :destroy
  validates :name, :start_date, :end_date, :slots_per_day, :rehearsals_per_group, presence: true
  validates :end_date, comparison: { greater_than: :start_date }
  validates :slots_per_day, comparison: { greater_than: 0 }
  validates :rehearsals_per_group, comparison: { greater_than: 0 }
  # scope for creating a custom query of the database. Show new created items on top.
  scope :ordered, -> { order(created_at: :desc) }
  # active storage
  has_one_attached :photo
end
