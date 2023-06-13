class Timeslot < ApplicationRecord
  belongs_to :festival
  validates :start_time, :end_time, presence: true
end
