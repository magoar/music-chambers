class Rehearsal < ApplicationRecord
  belongs_to :festival
  belongs_to :room
  belongs_to :group
end
