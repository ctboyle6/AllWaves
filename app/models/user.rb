class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :user_spots, dependent: :destroy
  has_many :spots, through: :user_spots
  has_many :preferences, dependent: :destroy
  has_one_attached :avatar

  before_create :create_default_preferences

  def grouped_preferences
    preferences.order("favourite DESC")
  end

  private

  def create_default_preferences
    preferences.new(name: "Default - Rookie", pref_unit: "M", swell_hgt_min: 0, swell_hgt_max: 4, swell_int_min: 10, swell_int_max: 20, swell_dir_min: 90, swell_dir_max: 270, wind_str_min: 4, wind_str_max: 7, wind_dir_min: 90, wind_dir_max: 270, pref_tide_position: "NORMAL", pref_tide_range: 1 )
    preferences.new(name: "Default - Mediocre", pref_unit: "M", swell_hgt_min: 0.5, swell_hgt_max: 2, swell_int_min: 10, swell_int_max: 15, swell_dir_min: 150, swell_dir_max: 200, wind_str_min: 2, wind_str_max: 10, wind_dir_min: 200, wind_dir_max: 300, pref_tide_position: "NORMAL", pref_tide_range: 2 )
    preferences.new(name: "Default - Advanced", pref_unit: "M", swell_hgt_min: 0.5, swell_hgt_max: 2, swell_int_min: 10, swell_int_max: 15, swell_dir_min: 150, swell_dir_max: 200, wind_str_min: 2, wind_str_max: 10, wind_dir_min: 200, wind_dir_max: 300, pref_tide_position: "HIGH", pref_tide_range: 3 )
  end
end
