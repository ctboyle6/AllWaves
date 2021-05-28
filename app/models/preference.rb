class Preference < ApplicationRecord
  belongs_to :user

  # Validations
  validates :name, presence: true
  validates :pref_unit, presence: true, inclusion: { in: %w[FT M] }
  validates :swell_hgt_min, presence: true
  validates :swell_hgt_max, presence: true
  validates :swell_int_min, presence: true
  validates :swell_int_max, presence: true
  validates :swell_dir_min, presence: true
  validates :swell_dir_max, presence: true
  validates :wind_str_min, presence: true
  validates :wind_str_max, presence: true
  validates :wind_dir_min, presence: true
  validates :wind_dir_max, presence: true
  validates :pref_tide_position, presence: true, inclusion: { in: %w[LOW NORMAL HIGH] }
end
