class Festival < ApplicationRecord
  belongs_to :user
  has_many :rooms, :groups, :rehearsals
end
