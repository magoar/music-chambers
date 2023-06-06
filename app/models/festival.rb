class Festival < ApplicationRecord
  belongs_to :user
  has_many :rooms, dependent: :destroy
  has_many :groups, dependent: :destroy
  has_many :musicians, through: :groups, dependent: :destroy
  has_many :rehearsals, dependent: :destroy
end
