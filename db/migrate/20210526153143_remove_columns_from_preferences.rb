class RemoveColumnsFromPreferences < ActiveRecord::Migration[6.0]
  def change
    remove_column :preferences, :pref_swell_height, :float
    remove_column :preferences, :pref_swell_int, :float
    remove_column :preferences, :pref_swell_direction, :float
    remove_column :preferences, :pref_wind_strength, :float
    remove_column :preferences, :pref_wind_direction, :float
  end
end
