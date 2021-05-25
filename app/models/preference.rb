class Preference < ApplicationRecord
  belongs_to :user, dependent: :destroy

  # Validations
  validates :name, presence: :true
  validates :pref_unit, presence: :true, inclusion: { in: %w(ft m) }
  validates :pref_swell_height, presence: :true
  validates :pref_swell_int, presence: :true
  validates :pref_swell_direction, presence: :true
  validates :pref_wind_strength, presence: :true
  validates :pref_wind_direction, presence: :true
  validates :pref_tide_position, presence: :true
  validates :pref_tide_range, presence: :true
end
