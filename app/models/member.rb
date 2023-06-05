class Member < ApplicationRecord
  belongs_to :group
  belongs_to :musician
end
