class Spot < ApplicationRecord

  has_many :user_spots
  has_many :conditions, dependent: :destroy

  validates :name, uniqueness: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :surfline_spot, uniqueness: true
  validates :surfline_subregion, presence: true
end
