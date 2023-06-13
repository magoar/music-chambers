class Timeslot < ApplicationRecord
  belongs_to :festival
  validates :start_time, presence: true
  validates :end_time, presence: true, comparison: { greater_than: :start_time }
end
