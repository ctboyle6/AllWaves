class Spot < ApplicationRecord
  has_many :user_spots, dependent: :destroy
  has_many :conditions, dependent: :destroy
  reverse_geocoded_by :latitude, :longitude

  validates :name, uniqueness: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :surfline_spot, uniqueness: true
  validates :surfline_subregion, presence: true
  include PgSearch::Model
  pg_search_scope :search_by_spot_name,
    against: :name,
    using: {
      tsearch: { prefix: true }
    }
end
