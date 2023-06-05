class Festival < ApplicationRecord
  belongs_to :user
  has_many :rooms
  has_many :groups
  has_many :rehearsals
end
