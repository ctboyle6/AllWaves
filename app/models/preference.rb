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

  def swell_h_range
    (swell_hgt_min..swell_hgt_max)
  end

  def swell_p_range
    (swell_int_min..swell_int_max)
  end

  def swell_d_range
    (swell_dir_min..swell_dir_max)
  end

  def wind_s_range
    (wind_str_min..wind_str_max)
  end

  def wind_d_range
    (wind_dir_min..wind_dir_max)
  end
end
