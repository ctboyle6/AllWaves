class AddApiColumnsToConditions < ActiveRecord::Migration[6.0]
  def change
    add_column :conditions, :timestamp, :integer
    add_column :conditions, :wind_strength, :float
    add_column :conditions, :wind_direction, :float
    add_column :conditions, :wind_gust, :float
    add_column :conditions, :wind_optimal_score, :float
    add_column :conditions, :waves_surf_min, :float
    add_column :conditions, :waves_surf_max, :float
    add_column :conditions, :waves_optimal_score, :float
    add_column :conditions, :waves_swell_height, :float
    add_column :conditions, :waves_swell_period, :float
    add_column :conditions, :waves_swell_direction, :float
    add_column :conditions, :waves_swell_direction_min, :float
    add_column :conditions, :waves_swell_optimal_score, :float
    add_column :conditions, :tide_type, :string
    add_column :conditions, :tide_height, :float

    remove_column :conditions, :conditions_json
  end
end
