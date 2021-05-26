class AddColumnsToPreferences < ActiveRecord::Migration[6.0]
  def change
    add_column :preferences, :swell_hgt_min, :float
    add_column :preferences, :swell_hgt_max, :float
    add_column :preferences, :swell_int_min, :float
    add_column :preferences, :swell_int_max, :float
    add_column :preferences, :swell_dir_min, :float
    add_column :preferences, :swell_dir_max, :float
    add_column :preferences, :wind_str_min, :float
    add_column :preferences, :wind_str_max, :float
    add_column :preferences, :wind_dir_min, :float
    add_column :preferences, :wind_dir_max, :float
  end
end
